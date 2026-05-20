require("mocha")

------------------
---- MONITORS ----
------------------

-- Built-in display
hl.monitor({
	output = "eDP-1",
	mode = "1920x1200",
	position = "0x0",
	scale = 1,
	bitdepth = 10,
})
-- External displays
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	mirror = "eDP-1",
	scale = 1,
})
-- LG Ultrawide
hl.monitor({
	output = "desc:LG Electronics LG ULTRAWIDE 0x00028060",
	mode = "3440x1440",
	position = "-3440x-600",
	scale = 1,
	bitdepth = 10,
})
-- Dell Monitor L
hl.monitor({
	output = "desc:Dell Inc. DELL P2419H DR79PF3",
	mode = "1920x1080",
	position = "-3840x-600",
	scale = 1,
	bitdepth = 10,
})
-- Dell Monitor R
hl.monitor({
	output = "desc:Dell Inc. DELL P2419H 1P59PF3",
	mode = "1920x1080",
	position = "-1920x-600",
	scale = 1,
	bitdepth = 10,
})

---------------------
---- MY PROGRAMS ----
---------------------

local flatpakPrefix = "/usr/bin/flatpak --socket=wayland run"
local flatpakSuffix = "--enable-features=UseOzonePlatform --ozone-platform=wayland"
local browser = "zen"
local term = "~/.config/hypr/scripts/ghostty_cwd.sh"
local fileManager = "dolphin"
local launcher = "qs -c noctalia-shell ipc call launcher toggle"
local music = flatpakPrefix .. " com.spotify.Client " .. flatpakSuffix
local phone = flatpakPrefix .. " org.ferdium.Ferdium " .. flatpakSuffix
local chat = "teams-for-linux"
local onePasswordQA = "1password --quick-access"
local notes = "~/Applications/Obsidian.AppImage"
local swaync = "swaync-client -t -sw"
local lock = "playerctl pause; qs -c noctalia-shell ipc call lockScreen lock"
local showDesktop = "~/.config/hypr/scripts/toggle_show_desktop.sh"
local randWall = "qs -c noctalia-shell ipc call wallpaper random"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("~/.config/hypr/scripts/random_wallpaper.sh")
	hl.exec_cmd("/usr/bin/1password --silent")
	hl.exec_cmd("/usr/libexec/pam_kwallet_init")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("~/.config/hypr/scripts/easyeffects.sh")
end)

hl.exec_cmd([[gsettings set org.gnome.desktop.interface gtk-theme "Breeze-Dark"]])
hl.exec_cmd([[gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"]])

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XCURSOR_SIZE", "24")
hl.env("ELECTRON_OZONE_PLATFORM", "wayland")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRSHOT_DIR", "Pictures/Screenshots")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 2,

		col = {
			active_border = { colors = { blue, mauve }, angle = 45 },
			inactive_border = surface1,
		},

		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 8,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		dim_special = 0.3,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 10,
			passes = 3,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4.1,
	bezier = "easeOutQuint",
	style = "popin 87%",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 1.49,
	bezier = "linear",
	style = "popin 87%",
})
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1.21, bezier = "quick" })
hl.animation({
	leaf = "specialWorkspaceIn",
	enabled = true,
	speed = 4.79,
	bezier = "easeOutQuint",
	style = "slidefadevert -30%",
})
hl.animation({
	leaf = "specialWorkspaceOut",
	enabled = true,
	speed = 1.5,
	bezier = "linear",
	style = "slidefadevert -30%",
})
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
hl.animation({ leaf = "monitorAdded", enabled = true, speed = 7, bezier = "quick" })

-- Larger gaps for special workspaces
hl.workspace_rule({ workspace = "s[true]", gaps_out = 24, gaps_in = 8 })

hl.config({
	dwindle = {
		preserve_split = false,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = false,
		enable_swallow = true,
		swallow_regex = "^(1password|kitty|alacritty|foot|wezterm|ghostty|konsole|org.kde.konsole|xfce4-terminal|gnome-terminal|tilix|foot|alacritty|st|flatpak)$",
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us,us",
		kb_variant = ",intl",
		kb_model = "",
		kb_options = "grp:alt_shift_toggle",
		kb_rules = "",

		repeat_rate = 60,
		repeat_delay = 200,

		follow_mouse = 1,
		sensitivity = 0,

		touchpad = {
			natural_scroll = true,
		},

		natural_scroll = true,
	},

	gestures = {
		workspace_swipe_distance = 100,
	},

	binds = {
		drag_threshold = 10,
	},
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "vertical", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "swipe", action = "move" })
hl.gesture({ fingers = 3, direction = "swipe", action = "resize", mods = "ALT" })
hl.gesture({ fingers = 3, direction = "up", action = "float", mods = "SUPER" })
hl.gesture({ fingers = 3, direction = "down", action = "close", mods = "SUPER" })

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"
local execMod = "SUPER + SHIFT"

-- Programs
hl.bind(execMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(execMod .. " + A", hl.dsp.exec_cmd(term .. " -e zsh -ic opencode"))
hl.bind(execMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(execMod .. " + T", hl.dsp.exec_cmd(term .. " -e btm"))
hl.bind(execMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(execMod .. " + N", hl.dsp.exec_cmd(notes))
hl.bind(execMod .. " + V", hl.dsp.exec_cmd(term .. " --workdir ~/projects -e zsh -ic nvim"))
hl.bind(execMod .. " + C", hl.dsp.exec_cmd(chat))
hl.bind(execMod .. " + M", hl.dsp.exec_cmd(music))
hl.bind(execMod .. " + P", hl.dsp.exec_cmd(phone))
hl.bind(execMod .. " + W", hl.dsp.exec_cmd(randWall))
hl.bind(execMod .. " + Q", hl.dsp.exit())

hl.bind("CTRL + SHIFT + space", hl.dsp.exec_cmd(onePasswordQA))
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(lock))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + semicolon", hl.dsp.exec_cmd(swaync))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(showDesktop))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + X", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + N", hl.dsp.window.pin())
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))

-- Screenshots
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Move focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Change workspaces
hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "e-1", on_current_monitor = true }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "e+1", on_current_monitor = true }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Move windows to workspace
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ workspace = "e+1" }))

-- Teams call shortcuts: pass mouse buttons through, send ctrl+shift+m/o if Teams is active
hl.bind("mouse:275", function()
	local w = hl.get_active_window()
	if w ~= nil and w.class == "teams-for-linux" then
		hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL + SHIFT", key = "m", state = "down" }))
		hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL + SHIFT", key = "m", state = "up" }))
	else
		hl.dispatch(hl.dsp.pass({ window = "activewindow" }))
	end
end)
hl.bind("mouse:276", function()
	local w = hl.get_active_window()
	if w ~= nil and w.class == "teams-for-linux" then
		hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL + SHIFT", key = "o", state = "down" }))
		hl.dispatch(hl.dsp.send_key_state({ mods = "CTRL + SHIFT", key = "o", state = "up" }))
	else
		hl.dispatch(hl.dsp.pass({ window = "activewindow" }))
	end
end)

-- Switch workspaces
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10, on_current_monitor = true }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Special workspaces
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("~"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:~" }))

hl.bind(mainMod .. " + minus", hl.dsp.workspace.toggle_special("-"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:-" }))

hl.bind(mainMod .. " + equal", hl.dsp.workspace.toggle_special("="))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.move({ workspace = "special:=" }))

-- Scroll through windows
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ direction = "right" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Float/maximize/kill with mouse clicks
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.float({ action = "toggle" }), { click = true })
hl.bind(mainMod .. " + mouse:274", hl.dsp.window.close(), { click = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.fullscreen(), { click = true })

-- Volume and brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd(lock), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "picture-in-picture",
	match = { title = "Picture-in-Picture" },
	float = true,
	pin = true,
	decorate = false,
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

-- Blur vicinae windows
hl.layer_rule({
	name = "vicinae-blur",
	match = { namespace = "vicinae" },
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	name = "vicinae-no-animation",
	match = { namespace = "vicinae" },
	no_anim = true,
})

-- Blur noctalia
hl.layer_rule({
	name = "noctalia-blur",
	match = { namespace = "noctalia-background-.*$" },
	blur = true,
	blur_popups = true,
	ignore_alpha = 0.5,
})
