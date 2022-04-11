local wezterm = require 'wezterm';
return {
    font = wezterm.font("MonoLisa", {font_size = 13}),
    line_height = 1.6,
    window_frame = {
        active_titlebar_bg = "#1f2025",
        inactive_titlebar_bg = "#1f2025"
    },
    colors = {
        foreground = "#d4d4d4",
        background = "#12131b",
        cursor_bg = "#d16cfe",
        cursor_fg = "#000",
        cursor_border = "#d16cfe",
        tab_bar = {
            new_tab = {bg_color = "#12131b", fg_color = "#d4d4d4"},
            active_tab = {
                bg_color = "#12131b",
                fg_color = "#d4d4d4",
                intensity = "Bold"
            },
            inactive_tab = {bg_color = "#1f2025", fg_color = "#d4d4d4"},
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
