if [ -f ~/.profile ]; then
  source ~/.profile
fi
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
alias lg='lazygit'

function zv() { z "$1"; nvim }
function zo() { z "$1"; opencode }

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

# pnpm
export PNPM_HOME="/home/dlacaille/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
