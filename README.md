# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

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
stow zsh astronvim

# Remove symlinks for a package
stow -D zsh
```

Stow creates symlinks in the parent directory (`$HOME` by default), so `dotfiles/zsh/.zshrc` becomes `~/.zshrc`.
