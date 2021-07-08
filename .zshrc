# load zinit
source `brew --prefix`/opt/zinit/zinit.zsh

setopt no_share_history
setopt promptsubst

# Make sure homebrew commands come first
export PATH=`brew --prefix`/bin:/`brew --prefix`sbin:/usr/bin:$PATH

# Node
export PATH=$PATH:`brew --prefix`/share/npm/bin

# Local bin
export PATH=$PATH:~/bin

# Bower
alias bower='noglob bower'

#------------------------------------------------------------------------------
# nvm
#------------------------------------------------------------------------------
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] \
#   && printf %s "${HOME}/.nvm" \
#   || printf %s "${XDG_CONFIG_HOME}/nvm")"

# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

#------------------------------------------------------------------------------
# Load oh-my-zsh plugins
#------------------------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/bundler
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/chruby
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
zinit light-mode is-snippet for \
  OMZP::bundler \
  OMZP::chruby \
  OMZP::git \
  id-as"fzf" ~/.fzf.zsh \
  id-as"steve-aliases" ~/.config/zsh/aliases.zsh \
  id-as"steve-chruby" ~/.config/zsh/chruby.zsh \
  id-as"steve-fzf" ~/.config/zsh/fzf.zsh \
  id-as"steve-iterm" ~/.config/zsh/iterm.zsh \
  id-as"steve-overmind" ~/.config/zsh/overmind.zsh \
  id-as"steve-ruby" ~/.config/zsh/ruby.zsh \
  id-as"steve-rust" ~/.config/zsh/rust.zsh \

# Completions
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/cargo
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ripgrep
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rust
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rustup
zinit light-mode as"completion" blockf for \
  OMZP::cargo/_cargo \
  OMZP::gh \
  OMZP::ripgrep/_ripgrep \
  OMZP::rust/_rust \
  OMZP::rustup/_rustup \
  `brew --prefix`/share/zsh/site-functions/**/* \
  light-mode zsh-users/zsh-completions \

export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')
export NVM_AUTO_USE=true

# These can all be delayed
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dash
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-hubflow
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rake-fast
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
zinit wait lucid for \
  OMZP::alias-finder \
  OMZP::brew \
  OMZP::colored-man-pages \
  OMZP::dash \
  OMZP::git-hubflow \
  OMZP::history \
  OMZP::rake-fast \
  light-mode OMZP::tmux \
  light-mode OMZP::vi-mode \
  light-mode zdharma/history-search-multi-word \
  atinit"zicompinit; zicdreplay" light-mode zdharma/fast-syntax-highlighting \
  atload'_zsh_autosuggest_start' light-mode zsh-users/zsh-autosuggestions \
  is-snippet `brew --prefix`/etc/profile.d/z.sh \
  lukechilds/zsh-nvm

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Final environment settings
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
export EDITOR=nvim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$(brew --prefix)/opt/binutils/bin:$PATH"

#---
# for vi-mode
#---
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

# From zsh brew install
unalias run-help
autoload run-help
HELPDIR=`brew --prefix`/share/zsh/help

# Keep this towards the end so other things can prep
autoload -Uz compinit
compinit

# https://starship.rs/
eval "$(starship init zsh)"
