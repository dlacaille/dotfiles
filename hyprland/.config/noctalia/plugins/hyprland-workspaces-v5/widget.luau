--!nonstrict
-- Hyprland Workspaces bar widget.
-- Each pill is a ui.row (fill + radius + padding) containing:
--   - a ui.button for the workspace label (switches workspace / toggles special)
--   - a ui.button per app window (focuses that window directly)
-- Since _G is readonly, all click globals are declared statically.

local workspaces  = noctalia.state.get("workspaces")  or {}
local monitors    = noctalia.state.get("monitors")    or {}
local clientsByWs = noctalia.state.get("clientsByWs") or {}
local icons       = noctalia.state.get("icons")       or {}

local function myMonitor()
  local setting = barWidget.getConfig("monitor") or ""
  if setting ~= "" then return setting end
  return noctalia.focusedOutputName() or ""
end

local function findMonitor(name)
  for _, m in ipairs(monitors) do
    if m.name == name then return m end
  end
  return nil
end

local function wsLabel(ws)
  local name = ws.name or ""
  if name:sub(1, 8) == "special:" then return name:sub(9) end
  if name ~= "" then return name end
  return tostring(ws.id)
end

local function isSpecial(ws)
  return (ws.name or ""):sub(1, 8) == "special:"
end

local function activeWsId(monitorName)
  local m = findMonitor(monitorName)
  return m and m.activeWorkspace and m.activeWorkspace.id
end

local function activeSpecialName(monitorName)
  local m = findMonitor(monitorName)
  if m and m.specialWorkspace and m.specialWorkspace.name ~= "" then
    return m.specialWorkspace.name
  end
  return nil
end

local function iconPath(class)
  if not class or class == "" then return nil end
  local lower = class:lower()
  if icons[lower] then return icons[lower] end
  local short = lower:match("^[a-z]+%.[a-z0-9]+%.(.+)$")
  if short and icons[short] then return icons[short] end
  return nil
end

local ICON_SIZE = 14
local GAP       = 4

-- ── Workspace label click handlers (1-20 + special) ──────────────────────────

local lastSpecialName = ""

function onWsClickSpecial()
  if lastSpecialName ~= "" then
    noctalia.runAsync("hyprctl dispatch togglespecialworkspace " .. lastSpecialName:sub(9))
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

local function wsClickName(ws)
  if isSpecial(ws) then
    lastSpecialName = ws.name
    return "onWsClickSpecial"
  end
  local id = ws.id
  if id >= 1 and id <= 20 then return wsClickNames[id] end
  return nil
end

-- ── Window focus click handlers (slots 1-50) ─────────────────────────────────
-- windowSlots[n] = address string, rebuilt each render before use.

local windowSlots = {}
local MAX_WIN_SLOTS = 50

local function focusWindow(slot)
  local addr = windowSlots[slot]
  if addr and addr ~= "" then
    noctalia.runAsync("hyprctl dispatch focuswindow address:" .. addr)
  end
end

function onWinFocus1()  focusWindow(1)  end
function onWinFocus2()  focusWindow(2)  end
function onWinFocus3()  focusWindow(3)  end
function onWinFocus4()  focusWindow(4)  end
function onWinFocus5()  focusWindow(5)  end
function onWinFocus6()  focusWindow(6)  end
function onWinFocus7()  focusWindow(7)  end
function onWinFocus8()  focusWindow(8)  end
function onWinFocus9()  focusWindow(9)  end
function onWinFocus10() focusWindow(10) end
function onWinFocus11() focusWindow(11) end
function onWinFocus12() focusWindow(12) end
function onWinFocus13() focusWindow(13) end
function onWinFocus14() focusWindow(14) end
function onWinFocus15() focusWindow(15) end
function onWinFocus16() focusWindow(16) end
function onWinFocus17() focusWindow(17) end
function onWinFocus18() focusWindow(18) end
function onWinFocus19() focusWindow(19) end
function onWinFocus20() focusWindow(20) end
function onWinFocus21() focusWindow(21) end
function onWinFocus22() focusWindow(22) end
function onWinFocus23() focusWindow(23) end
function onWinFocus24() focusWindow(24) end
function onWinFocus25() focusWindow(25) end
function onWinFocus26() focusWindow(26) end
function onWinFocus27() focusWindow(27) end
function onWinFocus28() focusWindow(28) end
function onWinFocus29() focusWindow(29) end
function onWinFocus30() focusWindow(30) end
function onWinFocus31() focusWindow(31) end
function onWinFocus32() focusWindow(32) end
function onWinFocus33() focusWindow(33) end
function onWinFocus34() focusWindow(34) end
function onWinFocus35() focusWindow(35) end
function onWinFocus36() focusWindow(36) end
function onWinFocus37() focusWindow(37) end
function onWinFocus38() focusWindow(38) end
function onWinFocus39() focusWindow(39) end
function onWinFocus40() focusWindow(40) end
function onWinFocus41() focusWindow(41) end
function onWinFocus42() focusWindow(42) end
function onWinFocus43() focusWindow(43) end
function onWinFocus44() focusWindow(44) end
function onWinFocus45() focusWindow(45) end
function onWinFocus46() focusWindow(46) end
function onWinFocus47() focusWindow(47) end
function onWinFocus48() focusWindow(48) end
function onWinFocus49() focusWindow(49) end
function onWinFocus50() focusWindow(50) end

local winFocusNames = {}
for i = 1, MAX_WIN_SLOTS do
  winFocusNames[i] = "onWinFocus" .. i
end

-- ── Rendering ─────────────────────────────────────────────────────────────────

local winSlotCounter = 0

local function renderPill(ws, monName)
  local special = isSpecial(ws)
  local wsId    = ws.id

  local active = false
  if special then
    active = (ws.name == activeSpecialName(monName))
  else
    active = (wsId == activeWsId(monName))
  end

  local urgent = ws.hasUrgent or false

  -- Variant drives the pill color and hover state on the label button.
  -- active+special -> secondary, active -> primary, urgent -> destructive, else ghost
  local variant
  if urgent then
    variant = "destructive"
  elseif active and special then
    variant = "secondary"
  elseif active then
    variant = "primary"
  else
    variant = "ghost"
  end

  -- Label button: pill shape + hover state + workspace switch on click
  local nodes = {
    ui.button({
      text     = wsLabel(ws),
      variant  = variant,
      selected = active,
      onClick  = wsClickName(ws),
    }),
  }

  -- Icon images: one per client, each focuses that window on click
  local clients = clientsByWs[wsId] or {}
  for _, c in ipairs(clients) do
    local path = iconPath(c.class)
    if path and winSlotCounter < MAX_WIN_SLOTS then
      winSlotCounter = winSlotCounter + 1
      windowSlots[winSlotCounter] = c.address
      table.insert(nodes, ui.image({
        path    = path,
        width   = ICON_SIZE,
        height  = ICON_SIZE,
        fit     = "contain",
        onClick = winFocusNames[winSlotCounter],
      }))
    end
  end

  -- Outer row: pill shape with explicit height so it doesn't stretch to full bar height
  local pill = barWidget.isVertical() and ui.column or ui.row
  return pill({
    fill      = active and (special and "secondary/0.2" or "primary/0.2") or "surface_variant/0.4",
    radius    = 99,
    paddingH  = 4,
    paddingV  = 0,
    height    = 24,
    gap       = 2,
    align     = "center",
  }, nodes)
end

local function render()
  -- Reset window slot assignments each render
  winSlotCounter = 0
  for i = 1, MAX_WIN_SLOTS do windowSlots[i] = "" end

  local monName = myMonitor()

  local regular, special = {}, {}
  for _, ws in ipairs(workspaces) do
    if isSpecial(ws) then
      if (ws.windows or 0) > 0 then table.insert(special, ws) end
    else
      table.insert(regular, ws)
    end
  end
  table.sort(regular, function(a, b) return (a.id or 0) < (b.id or 0) end)
  table.sort(special,  function(a, b) return (a.name or "") < (b.name or "") end)

  local pills = {}
  for _, ws in ipairs(regular) do table.insert(pills, renderPill(ws, monName)) end
  for _, ws in ipairs(special)  do table.insert(pills, renderPill(ws, monName)) end

  if #pills == 0 then
    barWidget.setVisible(false)
    return
  end
  barWidget.setVisible(true)

  local container = barWidget.isVertical() and ui.column or ui.row
  barWidget.render(container({ gap = GAP, align = "center" }, pills))
end

-- ── State watchers ────────────────────────────────────────────────────────────

noctalia.state.watch("workspaces",  function(v) workspaces  = v or {}; render() end)
noctalia.state.watch("monitors",    function(v) monitors    = v or {}; render() end)
noctalia.state.watch("clientsByWs", function(v) clientsByWs = v or {}; render() end)
noctalia.state.watch("icons",       function(v) icons       = v or {}; render() end)

function update()
  noctalia.setUpdateInterval(30000)
  render()
end
