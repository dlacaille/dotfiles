local wezterm = require("wezterm")

local LEFT_FIVE_EIGHTS_BLOCK = utf8.char(0x258b)
local RIGHT_HALF_BLOCK = utf8.char(0x2590)

wezterm.on("update-right-status", function(window, pane)
	-- "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.fa_terminal .. " wezterm  " },
		{ Foreground = { AnsiColor = "Red" } },
		{ Text = wezterm.nerdfonts.fa_user_o .. " " .. os.getenv("USER") .. "  " },
		-- {Foreground = {AnsiColor = "Blue"}}, {Text = bat .. "  "},
		{ Foreground = { AnsiColor = "Green" } },
		{ Text = wezterm.nerdfonts.mdi_clock .. " " .. date },
	}))
end)

return {
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font({
		family = "MonoLisa",
		weight = "Regular",
	}),
	font_size = 12.0,
	line_height = 1.1,
	use_fancy_tab_bar = false,
	tab_max_width = 48,
	prefer_egl = true,
	term = "xterm-256color",
	initial_cols = 120,
	initial_rows = 40,
	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	keys = { { key = "raw:33", mods = "CTRL", action = wezterm.action.SendString("\u{1e}") } },
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
