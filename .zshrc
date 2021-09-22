# cd without `cd`
setopt auto_cd
setopt no_share_history
setopt promptsubst

setopt vi

brew_prefix=`brew --prefix`

# Make sure homebrew commands come first
export PATH=$brew_prefix/bin:/$brew_prefix/sbin:/usr/bin:$PATH

# Node
export PATH=$PATH:$brew_prefix/share/npm/bin

# Local bin
export PATH=$PATH:~/bin

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
source $brew_prefix/etc/profile.d/z.sh
source ~/.config/zsh/*.zsh
source ~/.fzf.zsh

#------------------------------------------------------------------------------
# Completions; keep these towards the bottom in case other plugins add
# completions to zsh/functions/.
#------------------------------------------------------------------------------
# Keep this towards the end so other things can prep
autoload -Uz compinit
compinit

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
    zdharma/fast-syntax-highlighting.git/fast-syntax-highlighting.plugin.zsh \
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
HELPDIR=$brew_prefix/share/zsh/help

# https://starship.rs/
eval "$(starship init zsh)"

. <(zr zsh-users/zsh-syntax-highlighting.git/zsh-syntax-highlighting.plugin.zsh)
