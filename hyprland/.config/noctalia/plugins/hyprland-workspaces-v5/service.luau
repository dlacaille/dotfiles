--!nonstrict
-- Hyprland IPC service: streams workspace/client events from socket2, publishes
-- shared state consumed by widget instances.
--
-- State keys published:
--   "workspaces" : array of workspace tables from hyprctl -j workspaces
--   "monitors"   : array of monitor tables from hyprctl -j monitors
--   "clientsByWs": table mapping workspace id (number) -> array of client tables
--   "icons"      : table mapping app class (string) -> absolute icon path (string)

local POLL_EVENTS = {
  workspace      = true,
  focusedmon     = true,
  activewindow   = true,
  activespecial  = true,
  openwindow     = true,
  closewindow    = true,
  movewindow     = true,
  urgent         = true,
  destroyworkspace = true,
  createworkspace  = true,
}

local ICON_DIRS = {
  "/usr/share/icons/hicolor",
  "/usr/local/share/icons/hicolor",
}

local DESKTOP_DIRS = {
  "/usr/share/applications",
  "/usr/local/share/applications",
  "/var/lib/flatpak/exports/share/applications",
}

-- Add user-local icon and desktop dirs
local home = noctalia.getenv("HOME") or "/root"
table.insert(ICON_DIRS, 1, home .. "/.local/share/icons")
table.insert(DESKTOP_DIRS, home .. "/.local/share/applications")

-- Prefer larger sizes; pick the best candidate from a list of paths
local PREFERRED_SIZES = { "512x512", "256x256", "128x128", "scalable", "64x64", "48x48" }

local function sizeRank(path)
  for i, sz in ipairs(PREFERRED_SIZES) do
    if path:find(sz, 1, true) then return i end
  end
  return #PREFERRED_SIZES + 1
end

local function findIconFile(iconName)
  local best, bestRank = nil, 999
  for _, base in ipairs(ICON_DIRS) do
    local themes, _ = noctalia.listDir(base)
    if themes then
      for _, theme in ipairs(themes) do
        local appsDir = base .. "/" .. theme .. "/apps"
        for _, sz in ipairs(PREFERRED_SIZES) do
          for _, ext in ipairs({ ".png", ".svg" }) do
            local candidate = appsDir .. "/" .. sz .. "/" .. iconName .. ext
            if noctalia.fileExists(candidate) and not candidate:find("symbolic", 1, true) then
              local rank = sizeRank(candidate)
              if rank < bestRank then
                best, bestRank = candidate, rank
              end
            end
          end
        end
      end
    end
  end
  return best
end

-- Build icon cache: app-class -> icon path
-- Strategy: scan .desktop files, build class->iconName map, then resolve iconName->path
local function buildIconCache()
  local cache = {}

  for _, dir in ipairs(DESKTOP_DIRS) do
    local files, _ = noctalia.listDir(dir)
    if files then
      for _, fname in ipairs(files) do
        if fname:match("%.desktop$") then
          local path = dir .. "/" .. fname
          local content, _ = noctalia.readFile(path)
          if content then
            local iconName = content:match("\nIcon=([^\n]+)") or content:match("^Icon=([^\n]+)")
            local wmClass  = content:match("\nStartupWMClass=([^\n]+)") or content:match("^StartupWMClass=([^\n]+)")

            if iconName then
              iconName = noctalia.string.trim(iconName)
              -- Keys to try for this desktop file
              local keys = {}
              -- 1. StartupWMClass is the most reliable compositor class match
              if wmClass then
                table.insert(keys, noctalia.string.trim(wmClass):lower())
              end
              -- 2. desktop filename without extension (lowercased)
              local stem = fname:match("^(.-)%.desktop$")
              if stem then
                table.insert(keys, stem:lower())
                -- Also strip reverse-dns prefix: com.example.App -> app
                local short = stem:match("^[a-z]+%.[a-z0-9]+%.(.+)$")
                if short then table.insert(keys, short:lower()) end
              end

              for _, key in ipairs(keys) do
                if not cache[key] then
                  -- Resolve iconName to a file path
                  local iconPath = nil
                  -- If iconName is already an absolute path
                  if iconName:sub(1, 1) == "/" then
                    if noctalia.fileExists(iconName) then iconPath = iconName end
                  else
                    iconPath = findIconFile(iconName)
                    -- Fallback: try the class name itself as icon name
                    if not iconPath then
                      iconPath = findIconFile(key)
                    end
                  end
                  if iconPath then
                    cache[key] = iconPath
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  noctalia.state.set("icons", cache)
  local count = 0
  for _ in pairs(cache) do count = count + 1 end
  noctalia.log("Icon cache built: " .. tostring(count) .. " entries")
end

-- Fetch and publish workspace + monitor + client state
local pending = false

local function refresh()
  if pending then return end
  pending = true

  local wsData, monData, clientData = nil, nil, nil
  local done = 0

  local function tryPublish()
    done = done + 1
    if done < 3 then return end
    pending = false
    if not wsData or not monData or not clientData then return end

    -- Build clientsByWs: wsId -> list of clients
    local byWs = {}
    for _, c in ipairs(clientData) do
      local wsId = (c.workspace or {}).id
      if wsId then
        if not byWs[wsId] then byWs[wsId] = {} end
        table.insert(byWs[wsId], { class = c.class or "", title = c.title or "", monitor = c.monitor })
      end
    end

    noctalia.state.set("workspaces", wsData)
    noctalia.state.set("monitors", monData)
    noctalia.state.set("clientsByWs", byWs)
  end

  noctalia.runAsync("hyprctl -j workspaces", function(r)
    if r.exitCode == 0 then
      local data, _ = noctalia.json.decode(r.stdout)
      if data then wsData = data end
    end
    tryPublish()
  end)

  noctalia.runAsync("hyprctl -j monitors", function(r)
    if r.exitCode == 0 then
      local data, _ = noctalia.json.decode(r.stdout)
      if data then monData = data end
    end
    tryPublish()
  end)

  noctalia.runAsync("hyprctl -j clients", function(r)
    if r.exitCode == 0 then
      local data, _ = noctalia.json.decode(r.stdout)
      if data then clientData = data end
    end
    tryPublish()
  end)
end

-- Subscribe to Hyprland socket2 for live events
local function startEventStream()
  local sig = noctalia.getenv("HYPRLAND_INSTANCE_SIGNATURE")
  if not sig then
    noctalia.log("HYPRLAND_INSTANCE_SIGNATURE not set, falling back to polling")
    noctalia.setUpdateInterval(500)
    return
  end

  local sock = "/run/user/" .. (noctalia.getenv("UID") or "1000") .. "/hypr/" .. sig .. "/.socket2.sock"
  -- Try XDG_RUNTIME_DIR first, then /run/user/<id>
  local xdgRuntime = noctalia.getenv("XDG_RUNTIME_DIR")
  if xdgRuntime then
    sock = xdgRuntime .. "/hypr/" .. sig .. "/.socket2.sock"
  end

  local ok = noctalia.runStream("socat - UNIX-CONNECT:" .. sock, function(line)
    local event = line:match("^([^>]+)>>")
    if event and POLL_EVENTS[event] then
      refresh()
    end
  end)

  if not ok then
    noctalia.log("Failed to start event stream, falling back to polling")
    noctalia.setUpdateInterval(500)
  else
    -- Set a slow fallback interval in case the stream misses something
    noctalia.setUpdateInterval(5000)
  end
end

-- Startup
buildIconCache()
refresh()
startEventStream()

function update()
  refresh()
end
