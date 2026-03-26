source ~/.profile
emulate sh -c 'source /etc/profile'

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  dnf
  node
  npm
  you-should-use
  zsh-autosuggestions
  zsh-bat
  zsh-syntax-highlighting
  zsh-interactive-cd
  zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

alias v='nvim'
alias o='opencode'

export NODE_OPTIONS="--max-old-space-size=4096"
export EDITOR="nvim"

# Initialize zoxide
eval "$(zoxide init zsh)"

# Create ~/.zshrc.local if it doesn't exist and source it
if [ ! -f ~/.zshrc.local ]; then
  echo '# Add your local customizations here. For example, you can set your PATH variable:' > ~/.zshrc.local
  echo '# export PATH="$HOME/.example/bin:$PATH"' >> ~/.zshrc.local
fi
source ~/.zshrc.local
