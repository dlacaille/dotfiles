# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Features a "riced" [Hyprland](https://hypr.land/) config with [Noctalia Shell](https://noctalia.dev/) and a [Catppucin](https://catppuccin.com/)-based theme.

<img src="screenshot_empty.png" width="768">
<img src="screenshot_fetch.png" width="768">

## Structure

Each directory is a **stow package** mirroring the target directory tree relative to `$HOME`:

```
dotfiles/
├── zsh/
│   └── .bashrc
└── astronvim/
    └── .config/
        └── nvim/
            └── init.lua
```

## Usage

Clone the repo and use `stow` from within the `dotfiles` directory:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Symlink a package
stow zsh

# Symlink multiple packages
stow zsh astronvim hyprland lazygit vicinae vim

# Remove symlinks for a package
stow -D zsh
```

Stow creates symlinks in the parent directory (`$HOME` by default), so `dotfiles/zsh/.zshrc` becomes `~/.zshrc`.

## Hyprland Keybinds

Quick reference for keybindings defined in `hyprland/.config/hypr/hyprland.lua`.

`SUPER` is the main modifier, `SUPER + SHIFT` is the exec modifier for launching programs.

### Launch Programs

| Keybind | Action |
|---------|--------|
| `Super + Shift + Enter` | Terminal |
| `Super + Shift + A` | Terminal with OpenCode |
| `Super + Shift + B` | Browser (Zen) |
| `Super + Shift + T` | Terminal with btm |
| `Super + Shift + F` | File manager (Dolphin) |
| `Super + Shift + N` | Notes (Obsidian) |
| `Super + Shift + V` | Neovim in ~/projects |
| `Super + Shift + C` | Chat (Teams) |
| `Super + Shift + M` | Music (Spotify) |
| `Super + Shift + P` | Phone (Ferdium) |
| `Super + Shift + W` | Random wallpaper |
| `Super + Shift + Q` | Exit Hyprland |

### Window Management

| Keybind | Action |
|---------|--------|
| `Super + Q` | Close window |
| `Super + X` | Fullscreen |
| `Super + F` | Toggle float |
| `Super + N` | Pin window |
| `Super + P` | Pseudo-tile |
| `Super + T` | Toggle split |
| `Super + D` | Show desktop |

### Navigation

| Keybind | Action |
|---------|--------|
| `Super + H/J/K/L` | Move focus left/down/up/right |
| `Super + Shift + H/J/K/L` | Move window left/down/up/right |
| `Super + 1-9, 0` | Switch to workspace 1-10 |
| `Super + Shift + 1-9, 0` | Move window to workspace 1-10 |
| `Super + ,` / `Super + .` | Previous/next workspace |
| `Super + Shift + ,` / `Super + Shift + .` | Move window to prev/next workspace |

### Special Workspaces

| Keybind | Action |
|---------|--------|
| `` Super + ` `` | Toggle special workspace ~ |
| `Super + -` | Toggle special workspace - |
| `Super + =` | Toggle special workspace = |
| Add `Shift` to any above | Move window to that special workspace |

### Utilities

| Keybind | Action |
|---------|--------|
| `Super + Space` | Launcher |
| `Super + Escape` | Lock screen |
| `Super + ;` | Notification center |
| `Ctrl + Shift + Space` | 1Password quick access |
| `Print` | Screenshot region |
| `Shift + Print` | Screenshot window |
| `Super + Print` | Screenshot output |

### Media

Volume, brightness, and playback are bound to their respective XF86 keys.

## ZSH Configuration

The zsh package provides a `.zshrc` file which can be customized with a `.zshrc.local` file. This file will be automatically created by `.zshrc` if it does not exist.
