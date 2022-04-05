#---------------
# cd without `cd`
#---------------
setopt auto_cd
setopt no_share_history
setopt promptsubst
setopt vi

export GPG_TTY=$(tty)

#------------------------------------------------------------------------------
# nvm
#------------------------------------------------------------------------------
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')
export NVM_AUTO_USE=true

#------------------------------------------------------------------------------
# vi-mode
#------------------------------------------------------------------------------
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

#------------------------------------------------------------------------------
# Install plugins using zr
#------------------------------------------------------------------------------
. <(zr \
  ohmyzsh/ohmyzsh.git/plugins/brew/brew.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/bundler/bundler.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/colored-man-pages/colored-man-pages.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/dirhistory/dirhistory.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/git-hubflow/git-hubflow.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/vi-mode/vi-mode.plugin.zsh \
  lukechilds/zsh-nvm.git/zsh-nvm.plugin.zsh \
  djui/alias-tips.git/alias-tips.plugin.zsh \
)

#------------------------------------------------------------------------------
# local things
#------------------------------------------------------------------------------
eval "$(zoxide init --hook pwd zsh)"
source $HOME/.config/zsh/*.zsh
source $HOME/.config/zsh/chruby.zsh
source $HOME/.config/zsh/iterm.zsh
source $HOME/.config/zsh/myrails.plugin.zsh
source $HOME/.config/zsh/overmind.zsh
source $HOME/.config/zsh/ruby.zsh
source $HOME/.config/zsh/rust.zsh
source $HOME/.config/zsh/server.plugin.zsh
source $HOME/.fzf.zsh
source $HOME/.cargo/env

#------------------------------------------------------------------------------
# Completions; keep these towards the bottom in case other plugins add
# completions to zsh/functions/.
#------------------------------------------------------------------------------
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

install_completions() {
  . <(zr \
    ohmyzsh/ohmyzsh.git/plugins/bundler/_bundler \
    ohmyzsh/ohmyzsh.git/plugins/cargo/_cargo \
    ohmyzsh/ohmyzsh.git/plugins/rust/_rust \
    ohmyzsh/ohmyzsh.git/plugins/rustup/_rustup \
    ohmyzsh/ohmyzsh.git/plugins/chruby/chruby.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/git/git.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/nvm/nvm.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/rake-fast/rake-fast.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/tmux/tmux.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/docker-compose/docker-compose.plugin.zsh \
    zsh-users/zsh-autosuggestions.git/zsh-autosuggestions.plugin.zsh \
    zsh-users/zsh-completions.git/zsh-completions.plugin.zsh \
  )
}

install_completions

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Final environment settings
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Bower
alias bower='noglob bower'

export EDITOR=nvim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$brew_prefix/opt/binutils/bin:$PATH"

# From zsh brew install
unalias run-help
autoload run-help
export HELPDIR=$brew_prefix/share/zsh/help

# https://starship.rs/
eval "$(starship init zsh)"

. <(zr zsh-users/zsh-syntax-highlighting.git/zsh-syntax-highlighting.plugin.zsh)
