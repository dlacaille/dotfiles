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

-- Build icon cache async: delegates all file I/O to a shell script so the
-- Luau VM time budget is not exhausted by synchronous filesystem traversal.
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
    noctalia.state.set("icons", cache)
    local count = 0
    for _ in pairs(cache) do count = count + 1 end
    noctalia.log("Icon cache built: " .. tostring(count) .. " entries")
  end, 30000)
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
        table.insert(byWs[wsId], { class = c.class or "", title = c.title or "", monitor = c.monitor, address = c.address or "" })
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
