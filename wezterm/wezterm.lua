local wezterm = require("wezterm")

local LEFT_FIVE_EIGHTS_BLOCK = utf8.char(0x258b)
local RIGHT_HALF_BLOCK = utf8.char(0x2590)

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	-- local bat = ""
	-- for _, b in ipairs(wezterm.battery_info()) do
	--     local baticon = wezterm.nerdfonts.mdi_battery
	--     if b.state == "Charging" or b.state == "Full" then
	--         baticon = wezterm.nerdfonts.mdi_battery_charging
	--     else
	--         if b.state_of_charge < 0.95 then
	--             local index = math.floor(b.state_of_charge * 9 + 0.5)
	--             baticon = wezterm.nerdfonts["mdi_battery_" + (index + 1) * 10]
	--         end
	--     end
	--     bat =
	--         baticon .. " " .. string.format("%.0f%%", b.state_of_charge * 100) ..
	--             " " .. b.state
	-- end

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.fa_terminal .. " wezterm  " },
		{ Foreground = { AnsiColor = "Red" } },
		{ Text = wezterm.nerdfonts.fa_user_o .. " " .. os.getenv("USER") .. "  " },
		-- {Foreground = {AnsiColor = "Blue"}}, {Text = bat .. "  "},
		{ Foreground = { AnsiColor = "Green" } },
		{ Text = wezterm.nerdfonts.mdi_clock .. " " .. date },
	}))
end)

-- wezterm.on("format-tab-title",
--            function(tab, tabs, panes, config, hover, max_width)
--     local bar_background = "#0e0e14"
--     local background = "#13141c"
--     local edge_background = background
--     local edge_foreground = background
--     local foreground = "#3b4261"
--     if tab.is_active then
--         background = "#1a1b26"
--         foreground = "#c0caf5"
--         edge_background = "#7aa2f7"
--         edge_foreground = bar_background
--     elseif hover then
--         background = "#1a1b26"
--         foreground = "#c0caf5"
--         edge_background = background
--         edge_foreground = background
--     end
--     -- ensure that the titles fit in the available space,
--     -- and that we have room for the edges.
--     local title = wezterm.truncate_right(tab.active_pane.title, max_width - 3)
--     return {
--         {Background = {Color = edge_background}},
--         {Foreground = {Color = edge_foreground}},
--         {Text = LEFT_FIVE_EIGHTS_BLOCK}, {Background = {Color = background}},
--         {Text = " "}, {Foreground = {Color = foreground}}, {Text = title},
--         {Background = {Color = background}},
--         {Foreground = {Color = bar_background}}, {Text = RIGHT_HALF_BLOCK}
--     }
-- end)

return {
	color_scheme = "tokyonight-night",
	font = wezterm.font("MonoLisa"),
	font_size = 12.0,
	line_height = 1.4,
	use_fancy_tab_bar = false,
	tab_max_width = 48,
	prefer_egl = true,
	term = "wezterm",
	initial_cols = 120,
	initial_rows = 40,
	window_decorations = "RESIZE",
	-- window_background_opacity = 0.8,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	colors = {
		-- cursor_bg = "#d16cfe",
		-- cursor_fg = "#000",
		-- cursor_border = "#d16cfe",
		split = "black",
		tab_bar = {
			background = "none",
			new_tab = { bg_color = "black", fg_color = "#c0caf5" },
			active_tab = {
				bg_color = "#7aa2f7",
				fg_color = "black",
				intensity = "Bold",
			},
			inactive_tab_hover = {
				bg_color = "black",
				fg_color = "white",
				italic = true,
			},
			new_tab_hover = {
				bg_color = "black",
				fg_color = "white",
				italic = true,
			},
			inactive_tab = {
				bg_color = "black",
				fg_color = "#c0caf5",
				italic = true,
			},
		},
	},
}
