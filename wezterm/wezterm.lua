local wezterm = require 'wezterm';
return {
    font = wezterm.font("MonoLisa", {font_size = 13}),
    line_height = 1.6,
    use_fancy_tab_bar = false,
    tab_max_width = 48,
    window_frame = {
        active_titlebar_bg = "#0a0b0d",
        inactive_titlebar_bg = "#0a0b0d"
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
        foreground = "#d4d4d4",
        background = "#131419",
        cursor_bg = "#d16cfe",
        cursor_fg = "#000",
        cursor_border = "#d16cfe",
        tab_bar = {
            background = "#0a0b0d",
            new_tab = {bg_color = "#0a0b0d", fg_color = "#d4d4d4"},
            active_tab = {
                bg_color = "#1f2025",
                fg_color = "#d4d4d4",
                intensity = "Bold"
            },
            inactive_tab = {bg_color = "#0a0b0d", fg_color = "#d4d4d4"},
            inactive_tab_edge = "#2b2b30"
        },
        ansi = {
            "#191e2a", "#ed8274", "#a6cc70", "#fad07b", "#6dcbfa", "#cfbafa",
            "#90e1c6", "#c7c7c7"
        },
        brights = {
            "#191e2a", "#ed8274", "#a6cc70", "#fad07b", "#6dcbfa", "#cfbafa",
            "#90e1c6", "#c7c7c7"
        }
    }
}
