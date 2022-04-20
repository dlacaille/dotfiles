local wezterm = require 'wezterm';
return {
    color_scheme = "tokyonight-night",
    font = wezterm.font("MonoLisa", {font_size = 13}),
    line_height = 1.6,
    use_fancy_tab_bar = false,
    tab_max_width = 48,
    disable_default_mouse_bindings = true,
    term = "wezterm",
    set_environment_variables = {
        TERMINFO_DIRS = os.getenv("HOME") .. '/.config/.terminfo',
        WSLENV = 'TERMINFO_DIRS'
    },
    keys = {
        {
            key = "v",
            mods = "SHIFT|CMD",
            action = wezterm.action {
                SplitVertical = {domain = "CurrentPaneDomain"}
            }
        }, {
            key = "h",
            mods = "SHIFT|CMD",
            action = wezterm.action {
                SplitHorizontal = {domain = "CurrentPaneDomain"}
            }
        }, {
            key = "x",
            mods = "SHIFT|CMD",
            action = wezterm.action {CloseCurrentPane = {confirm = true}}
        }, {key = "z", mods = "CMD", action = "TogglePaneZoomState"}, {
            key = "l",
            mods = "CMD",
            action = wezterm.action {ActivatePaneDirection = "Right"}
        }, {
            key = "h",
            mods = "CMD",
            action = wezterm.action {ActivatePaneDirection = "Left"}
        }, {
            key = "j",
            mods = "CMD",
            action = wezterm.action {ActivatePaneDirection = "Down"}
        }, {
            key = "k",
            mods = "CMD",
            action = wezterm.action {ActivatePaneDirection = "Up"}
        }, {
            key = "l",
            mods = "CTRL|SHIFT|CMD",
            action = wezterm.action {AdjustPaneSize = {"Right", 1}}
        }, {
            key = "h",
            mods = "CTRL|SHIFT|CMD",
            action = wezterm.action {AdjustPaneSize = {"Left", 1}}
        }, {
            key = "j",
            mods = "CTRL|SHIFT|CMD",
            action = wezterm.action {AdjustPaneSize = {"Down", 1}}
        }, {
            key = "k",
            mods = "CTRL|SHIFT|CMD",
            action = wezterm.action {AdjustPaneSize = {"Up", 1}}
        }
    },
    window_padding = {left = 0, right = 0, top = 0, bottom = 0},
    colors = {
        -- cursor_bg = "#d16cfe",
        -- cursor_fg = "#000",
        -- cursor_border = "#d16cfe",
        tab_bar = {
            background = "#0e0e14",
            new_tab = {bg_color = "#16161e", fg_color = "#c0caf5"},
            active_tab = {
                bg_color = "#1a1b26",
                fg_color = "#c0caf5",
                intensity = "Bold"
            },
            inactive_tab_hover = {
                bg_color = "#1a1b26",
                fg_color = "#c0caf5",
                italic = true
            },
            new_tab_hover = {
                bg_color = "#1a1b26",
                fg_color = "#c0caf5",
                italic = true
            },
            inactive_tab = {bg_color = "#13141c", fg_color = "#c0caf5"}
        }
    }
}
