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
brew install slack discord firefox google-chrome docker fzf rg bat stylua go karabiner-elements lazygit openjdk@11

echo "Installing python"
brew install pyenv
pyenv install 2.7.18

echo "Setting up git"
git config --global user.name "Dominic Lacaille"
git config --global user.email "dominic@swoo.ca"
git config --global core.excludesFile '~/.config/gitignore'

echo "Setting up node"
brew install node
npm install -g n
npm login --registry=https://npm.pkg.github.com
n install 14.19.0

echo "Installing global npm packages"
npm install -g @fsouza/prettierd eslint_d stylelint

echo "Creating Projects folder"
mkdir ~/Projects

echo "Setting up php"
brew install php@7.4

echo "Setting up composer"
# Force here makes sure composer uses whatever php version we have.
brew install composer --force 

echo "Setting up valet"
composer global require weprovide/valet-plus
valet install
cd Projects
valet park
cd

echo "Installing tmux"
brew install tmux tmuxinator
ln -s .config/.tmux.conf .tmux.conf

echo "Installing neovim"
brew install neovim --HEAD
git clone --depth 1 https://github.com/wbthomason/packer.nvim\\n ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "Installing php-cs-fixer"
composer global require friendsofphp/php-cs-fixer -W

echo "Installing wezterm"
brew tap wez/wezterm
brew install --cask wez/wezterm/wezterm-nightly
tempfile=$(mktemp) \\n  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \\n  && tic -x -o ~/.terminfo $tempfile \\n  && rm $tempfile
