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

-- Click handlers: _G is readonly in v5, so each handler must be a declared global.
-- Regular workspaces 1-20 get one named global each.
-- Special workspaces share one trampoline; the name is stored at render time
-- (only one pill can be clicked at a time).

local lastClickedSpecialName = ""

function onWsClickSpecial()
  if lastClickedSpecialName ~= "" then
    noctalia.runAsync("hyprctl dispatch togglespecialworkspace " .. lastClickedSpecialName:sub(9))
  end
end

function onWsClick1()  noctalia.runAsync("hyprctl dispatch workspace 1")  end
function onWsClick2()  noctalia.runAsync("hyprctl dispatch workspace 2")  end
function onWsClick3()  noctalia.runAsync("hyprctl dispatch workspace 3")  end
function onWsClick4()  noctalia.runAsync("hyprctl dispatch workspace 4")  end
function onWsClick5()  noctalia.runAsync("hyprctl dispatch workspace 5")  end
function onWsClick6()  noctalia.runAsync("hyprctl dispatch workspace 6")  end
function onWsClick7()  noctalia.runAsync("hyprctl dispatch workspace 7")  end
function onWsClick8()  noctalia.runAsync("hyprctl dispatch workspace 8")  end
function onWsClick9()  noctalia.runAsync("hyprctl dispatch workspace 9")  end
function onWsClick10() noctalia.runAsync("hyprctl dispatch workspace 10") end
function onWsClick11() noctalia.runAsync("hyprctl dispatch workspace 11") end
function onWsClick12() noctalia.runAsync("hyprctl dispatch workspace 12") end
function onWsClick13() noctalia.runAsync("hyprctl dispatch workspace 13") end
function onWsClick14() noctalia.runAsync("hyprctl dispatch workspace 14") end
function onWsClick15() noctalia.runAsync("hyprctl dispatch workspace 15") end
function onWsClick16() noctalia.runAsync("hyprctl dispatch workspace 16") end
function onWsClick17() noctalia.runAsync("hyprctl dispatch workspace 17") end
function onWsClick18() noctalia.runAsync("hyprctl dispatch workspace 18") end
function onWsClick19() noctalia.runAsync("hyprctl dispatch workspace 19") end
function onWsClick20() noctalia.runAsync("hyprctl dispatch workspace 20") end

local wsClickNames = {
  "onWsClick1",  "onWsClick2",  "onWsClick3",  "onWsClick4",  "onWsClick5",
  "onWsClick6",  "onWsClick7",  "onWsClick8",  "onWsClick9",  "onWsClick10",
  "onWsClick11", "onWsClick12", "onWsClick13", "onWsClick14", "onWsClick15",
  "onWsClick16", "onWsClick17", "onWsClick18", "onWsClick19", "onWsClick20",
}

local function clickNameFor(ws)
  if isSpecial(ws) then
    lastClickedSpecialName = ws.name
    return "onWsClickSpecial"
  end
  local id = ws.id
  if id >= 1 and id <= 20 then return wsClickNames[id] end
  return nil
end

local function renderPill(ws, monName)
  local special = isSpecial(ws)
  local wsId = ws.id

  local active = false
  if special then
    active = (ws.name == activeSpecialName(monName))
  else
    active = (wsId == activeWsId(monName))
  end

  local urgent = ws.hasUrgent or false

  -- Build label: workspace name + icon filenames as text is not possible,
  -- so we compose a ui.row pill: styled row for visuals, ui.button for clicks.
  local fg
  local bg
  if urgent then
    bg, fg = "tertiary", "on_tertiary"
  elseif active and special then
    bg, fg = "secondary", "on_secondary"
  elseif active then
    bg, fg = "primary", "on_primary"
  else
    bg, fg = "surface_variant", "on_surface_variant"
  end

  -- Inner content: label + app icons
  local content = {}
  table.insert(content, ui.label({
    text       = wsLabel(ws),
    color      = fg,
    fontWeight = active and "bold" or "medium",
  }))
  local clients = clientsByWs[wsId] or {}
  for _, c in ipairs(clients) do
    local path = iconPath(c.class)
    if path then
      table.insert(content, ui.image({
        path   = path,
        width  = ICON_SIZE,
        height = ICON_SIZE,
        fit    = "contain",
      }))
    end
  end

  -- Styled pill: ui.row provides fill/radius/padding/children.
  -- onClick goes on ui.image or ui.box wrapping the row, but since neither
  -- works, we use the widget-level onClick trampoline via a nested ui.button
  -- (ghost, zero padding) that sits over the label.
  local innerRow = barWidget.isVertical() and ui.column or ui.row
  local clickName = clickNameFor(ws)

  -- Wrap the whole pill in a ui.button (ghost variant) to get onClick support,
  -- with the styled row as a child label substitute. Since ui.button children
  -- may not render, we use text= for the label and accept no icons for now.
  -- TODO: find a way to render icons inside clickable pills once the API clarifies.
  local pillLabel = wsLabel(ws)
  -- Append a dot per client as a minimal icon indicator when icons can't render
  local clientCount = #clients
  if clientCount > 0 then
    pillLabel = pillLabel .. string.rep(" ·", clientCount)
  end

  local buttonProps = {
    text     = pillLabel,
    variant  = active and "primary" or (urgent and "destructive" or "ghost"),
    selected = active,
    onClick  = clickName,
  }
  if not clickName then buttonProps.onClick = nil end
  return ui.button(buttonProps)
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

-- Watch for state changes from the service
noctalia.state.watch("workspaces", function(v)
  workspaces = v or {}
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
