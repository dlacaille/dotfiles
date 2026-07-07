--!nonstrict
-- Hyprland IPC service: streams workspace/client events from socket2, publishes
-- shared state consumed by widget instances.
--
-- State keys published:
--   "workspaces"  : array of workspace tables from hyprctl -j workspaces
--   "monitors"    : array of monitor tables from hyprctl -j monitors
--   "clientsByWs" : table mapping workspace id -> array of { class, address }
--   "icons"       : table mapping app class -> absolute icon path
--   "composites"  : table mapping workspace id -> composite PNG path (or nil)

local POLL_EVENTS = {
  workspace        = true,
  focusedmon       = true,
  activewindow     = true,
  activespecial    = true,
  openwindow       = true,
  closewindow      = true,
  movewindow       = true,
  urgent           = true,
  destroyworkspace = true,
  createworkspace  = true,
}

local COMPOSITE_DIR = "/tmp/noctalia-hyprland-ws"
local ICON_SIZE     = 16
local ICON_GAP      = 2

-- Per-workspace cache: wsId -> sorted class-list string used as change key
local wsIconHash = {}
-- Current composite paths: wsId -> path
local composites = {}
-- Icons state (populated async by buildIconCache)
local icons = {}

-- ── Icon cache ────────────────────────────────────────────────────────────────

local function buildIconCache()
  local pluginDir = noctalia.pluginDir() or ""
  local script = pluginDir .. "/build-icon-cache.sh"
  noctalia.runAsync("bash " .. script, function(r)
    if r.exitCode ~= 0 or r.stdout == "" then
      noctalia.log("Icon cache script failed: " .. (r.stderr or ""))
      return
    end
    local cache, err = noctalia.json.decode(r.stdout)
    if not cache then
      noctalia.log("Icon cache JSON parse failed: " .. tostring(err))
      return
    end
    icons = cache
    noctalia.state.set("icons", cache)
    local count = 0
    for _ in pairs(cache) do count = count + 1 end
    noctalia.log("Icon cache built: " .. tostring(count) .. " entries")
    -- Trigger composite generation now that icons are available
    generateAllComposites()
  end, 30000)
end

-- ── Composite generation ──────────────────────────────────────────────────────

local function resolveIcon(class)
  if not class or class == "" then return nil end
  local lower = class:lower()
  if icons[lower] then return icons[lower] end
  local short = lower:match("^[a-z]+%.[a-z0-9]+%.(.+)$")
  if short and icons[short] then return icons[short] end
  return nil
end

local function generateComposite(wsId, clients)
  -- Build ordered list of resolved icon paths (one per window, preserving order)
  local paths = {}
  for _, c in ipairs(clients) do
    local p = resolveIcon(c.class)
    if p then table.insert(paths, p) end
  end

  local outPath = COMPOSITE_DIR .. "/ws-" .. tostring(wsId) .. ".png"

  if #paths == 0 then
    -- No icons: remove stale composite if any
    if composites[wsId] then
      composites[wsId] = nil
      noctalia.state.set("composites", composites)
    end
    return
  end

  if #paths == 1 then
    -- Single icon: just resize
    local cmd = string.format(
      "magick \\( %q -resize %dx%d \\) %q",
      paths[1], ICON_SIZE, ICON_SIZE, outPath
    )
    noctalia.runAsync(cmd, function(r)
      if r.exitCode == 0 then
        composites[wsId] = outPath
        noctalia.state.set("composites", composites)
      else
        noctalia.log("magick single failed ws " .. tostring(wsId) .. ": " .. (r.stderr or ""))
      end
    end)
    return
  end

  -- Multiple icons: resize each in parentheses, interleave transparent spacers, +append
  local parts = {}
  for i, p in ipairs(paths) do
    table.insert(parts, string.format("\\( %q -resize %dx%d \\)", p, ICON_SIZE, ICON_SIZE))
    if i < #paths then
      table.insert(parts, string.format("\\( xc:none -geometry %dx%d \\)", ICON_GAP, ICON_SIZE))
    end
  end
  local cmd = string.format("magick %s +append %q", table.concat(parts, " "), outPath)
  noctalia.runAsync(cmd, function(r)
    if r.exitCode == 0 then
      composites[wsId] = outPath
      noctalia.state.set("composites", composites)
    else
      noctalia.log("magick append failed ws " .. tostring(wsId) .. ": " .. (r.stderr or ""))
    end
  end)
end

function generateAllComposites()
  local clientsByWs = noctalia.state.get("clientsByWs") or {}
  if not next(icons) then return end  -- icons not ready yet

  for wsId, clients in pairs(clientsByWs) do
    -- Build cache key: sorted class names joined
    local classes = {}
    for _, c in ipairs(clients) do
      table.insert(classes, c.class or "")
    end
    local key = table.concat(classes, "|")

    if wsIconHash[wsId] ~= key then
      wsIconHash[wsId] = key
      generateComposite(wsId, clients)
    end
  end

  -- Clear composites for workspaces that no longer exist
  for wsId in pairs(composites) do
    if not clientsByWs[wsId] then
      composites[wsId] = nil
    end
  end
  noctalia.state.set("composites", composites)
end

-- ── Hyprland IPC ─────────────────────────────────────────────────────────────

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

    local byWs = {}
    for _, c in ipairs(clientData) do
      local wsId = (c.workspace or {}).id
      if wsId then
        if not byWs[wsId] then byWs[wsId] = {} end
        table.insert(byWs[wsId], { class = c.class or "", address = c.address or "" })
      end
    end

    noctalia.state.set("workspaces", wsData)
    noctalia.state.set("monitors",   monData)
    noctalia.state.set("clientsByWs", byWs)

    generateAllComposites()
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

local function startEventStream()
  local sig = noctalia.getenv("HYPRLAND_INSTANCE_SIGNATURE")
  if not sig then
    noctalia.log("HYPRLAND_INSTANCE_SIGNATURE not set, falling back to polling")
    noctalia.setUpdateInterval(500)
    return
  end

  local xdgRuntime = noctalia.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. (noctalia.getenv("UID") or "1000"))
  local sock = xdgRuntime .. "/hypr/" .. sig .. "/.socket2.sock"

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
    noctalia.setUpdateInterval(5000)
  end
end

-- ── Startup ───────────────────────────────────────────────────────────────────

noctalia.runAsync("mkdir -p " .. COMPOSITE_DIR)
buildIconCache()
refresh()
startEventStream()

function update()
  refresh()
end
