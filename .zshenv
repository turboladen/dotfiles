#------------------------------------------------------------------------------
# This file is _always_ sourced; ~/.zshrc is only sourced for interactive
# sessions
#------------------------------------------------------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.config/zsh/chruby.zsh"
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

# Make pyenv pythons available
PATH=$(pyenv root)/shims:$PATH

# Make mason tools available
# export PATH=$PATH:~/.local/share/nvim/mason/bin
