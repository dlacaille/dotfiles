cd

echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Setting up Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setting up dotfiles"
ln -s .config/.zshrc .zshrc

echo "Configuring MacOs"
defaults write com.apple.dock static-only -bool true
killall Dock
defaults write com.apple.finder CreateDesktop false
killall Finder
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
defaults write -g ApplePressAndHoldEnabled -bool false

echo "Configuring lazygit"
ln -s ~/.config/lazygit ~/Library/Application\ Support/lazygit

echo "Installing common apps with homebrew..."
brew install slack firefox google-chrome docker fzf rg bat go karabiner-elements lazygit

echo "Setting up git"
git config --global user.name "Dominic Lacaille"
git config --global user.email "dominic@lacaille.app"
git config --global core.excludesFile '~/.config/gitignore'

echo "Setting up node"
brew install nvm
nvm install --lts

echo "Creating Projects folder"
mkdir ~/Projects

echo "Installing wezterm"
brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm

echo "Installing AstroNvim"
brew install neovim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
ln -s ~/.config/astronvim/lua/user ~/.config/nvim/lua
