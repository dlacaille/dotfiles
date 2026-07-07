--!nonstrict
-- Hyprland Workspaces bar widget.
-- Renders workspace pills with app icons and special workspace support.
-- Each bar instance reads its "monitor" setting to determine which monitor
-- it belongs to. Leave monitor="" to follow the focused monitor (single-monitor
-- setups or when only one bar is used).

local workspaces  = noctalia.state.get("workspaces")  or {}
local monitors    = noctalia.state.get("monitors")    or {}
local clientsByWs = noctalia.state.get("clientsByWs") or {}
local icons       = noctalia.state.get("icons")       or {}

-- Resolve our monitor name: explicit setting wins, else focused output
local function myMonitor()
  local setting = barWidget.getConfig("monitor") or ""
  if setting ~= "" then return setting end
  return noctalia.focusedOutputName() or ""
end

-- Find the monitor table matching a connector name
local function findMonitor(name)
  for _, m in ipairs(monitors) do
    if m.name == name then return m end
  end
  return nil
end

-- Strip "special:" prefix for display
local function wsLabel(ws)
  local name = ws.name or ""
  if name:sub(1, 8) == "special:" then
    return name:sub(9)
  end
  if name ~= "" then return name end
  return tostring(ws.id)
end

local function isSpecial(ws)
  local name = ws.name or ""
  return name:sub(1, 8) == "special:"
end

-- Determine active workspace id per monitor
local function activeWsId(monitorName)
  local m = findMonitor(monitorName)
  if m and m.activeWorkspace then
    return m.activeWorkspace.id
  end
  return nil
end

-- Determine active special workspace name per monitor
local function activeSpecialName(monitorName)
  local m = findMonitor(monitorName)
  if m and m.specialWorkspace and m.specialWorkspace.name ~= "" then
    return m.specialWorkspace.name
  end
  return nil
end

-- Resolve icon path for an app class
local function iconPath(class)
  if not class or class == "" then return nil end
  local lower = class:lower()
  -- Direct match
  if icons[lower] then return icons[lower] end
  -- Strip reverse-dns prefix: com.example.App -> app
  local short = lower:match("^[a-z]+%.[a-z0-9]+%.(.+)$")
  if short and icons[short] then return icons[short] end
  return nil
end

local ICON_SIZE = 14
local PILL_RADIUS = 6
local PILL_PAD_H = 6
local PILL_PAD_V = 2
local GAP = 4

local function renderPill(ws, monName)
  local special = isSpecial(ws)
  local wsId = ws.id

  -- Determine active state
  local active = false
  if special then
    active = (ws.name == activeSpecialName(monName))
  else
    active = (wsId == activeWsId(monName))
  end

  local urgent = ws.hasUrgent or false

  -- Colors
  local bg, fg
  if urgent then
    bg, fg = "tertiary", "on_tertiary"
  elseif active and special then
    bg, fg = "secondary", "on_secondary"
  elseif active then
    bg, fg = "primary", "on_primary"
  else
    bg, fg = "surface_variant", "on_surface_variant"
  end

  -- Build pill contents
  local children = {}

  -- Workspace label
  table.insert(children, ui.label({
    text       = wsLabel(ws),
    color      = fg,
    fontWeight = active and "bold" or "medium",
  }))

  -- App icons for clients on this workspace
  local clients = clientsByWs[wsId] or {}
  for _, c in ipairs(clients) do
    local path = iconPath(c.class)
    if path then
      table.insert(children, ui.image({
        path   = path,
        width  = ICON_SIZE,
        height = ICON_SIZE,
        fit    = "contain",
      }))
    end
  end

  local container = barWidget.isVertical() and ui.column or ui.row
  return ui.box({ fill = bg, radius = PILL_RADIUS, paddingH = PILL_PAD_H, paddingV = PILL_PAD_V,
    onClick = "onClickWs_" .. tostring(wsId) }, {
    container({ gap = 4, align = "center" }, children),
  })
end

local function render()
  local monName = myMonitor()

  -- Sort: regular workspaces by id, specials appended after
  local regular, special = {}, {}
  for _, ws in ipairs(workspaces) do
    if isSpecial(ws) then
      -- Only show special workspaces that have windows
      if (ws.windows or 0) > 0 then
        table.insert(special, ws)
      end
    else
      table.insert(regular, ws)
    end
  end
  table.sort(regular, function(a, b) return (a.id or 0) < (b.id or 0) end)
  table.sort(special, function(a, b) return (a.name or "") < (b.name or "") end)

  local pills = {}
  for _, ws in ipairs(regular) do
    table.insert(pills, renderPill(ws, monName))
  end
  for _, ws in ipairs(special) do
    table.insert(pills, renderPill(ws, monName))
  end

  if #pills == 0 then
    barWidget.setVisible(false)
    return
  end
  barWidget.setVisible(true)

  local container = barWidget.isVertical() and ui.column or ui.row
  barWidget.render(container({ gap = GAP, align = "center" }, pills))
end

-- Workspace click handlers: one global per possible workspace id.
local function makeClickHandler(wsId)
  return function()
    noctalia.runAsync("hyprctl dispatch workspace " .. tostring(wsId))
  end
end

-- Pre-register regular workspaces 1-20
for i = 1, 20 do
  local id = i
  _G["onClickWs_" .. tostring(id)] = makeClickHandler(id)
end

-- Register click handlers for special workspaces (negative ids) and ids >20
local function refreshClickHandlers()
  for _, ws in ipairs(workspaces) do
    local id = ws.id
    if id then
      if isSpecial(ws) then
        local name = ws.name
        _G["onClickWs_" .. tostring(id)] = function()
          local shortName = name:sub(9)
          noctalia.runAsync("hyprctl dispatch togglespecialworkspace " .. shortName)
        end
      elseif id > 20 then
        _G["onClickWs_" .. tostring(id)] = makeClickHandler(id)
      end
    end
  end
end

-- Watch for state changes from the service
noctalia.state.watch("workspaces", function(v)
  workspaces = v or {}
  refreshClickHandlers()
  render()
end)

noctalia.state.watch("monitors", function(v)
  monitors = v or {}
  render()
end)

noctalia.state.watch("clientsByWs", function(v)
  clientsByWs = v or {}
  render()
end)

noctalia.state.watch("icons", function(v)
  icons = v or {}
  render()
end)

function update()
  noctalia.setUpdateInterval(30000)
  render()
end
