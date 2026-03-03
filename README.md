# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Features a "riced" [Hyprland](https://hypr.land/) config with a [Catppucin](https://catppuccin.com/)-based theme.

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

## ZSH Configuration

The zsh package provides a `.zshrc` file which can be customized with a `.zshrc.local` file. This file will be automatically created by `.zshrc` if it does not exist.
