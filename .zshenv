#------------------------------------------------------------------------------
# This file is _always_ sourced; ~/.zshrc is only sourced for interactive
# sessions
#------------------------------------------------------------------------------
eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.config/zsh/chruby.zsh"
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"
