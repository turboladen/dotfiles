# ╭──────────────────────────╮
# │ Install plugins using zr │
# ╰──────────────────────────╯
. <(zr \
  ohmyzsh/ohmyzsh.git/plugins/brew/brew.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/colored-man-pages/colored-man-pages.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/dirhistory/dirhistory.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/git-hubflow/git-hubflow.plugin.zsh \
  ohmyzsh/ohmyzsh.git/plugins/vi-mode/vi-mode.plugin.zsh \
  djui/alias-tips.git/alias-tips.plugin.zsh
)

# ╭──────────────╮
# │ local things │
# ╰──────────────╯
eval "$(zoxide init --hook pwd zsh)"
source "$HOME"/.config/zsh/*.zsh
source "$HOME/.config/zsh/chruby.zsh"
source "$HOME/.config/zsh/myrails.plugin.zsh"
source "$HOME/.config/zsh/overmind.zsh"
source "$HOME/.config/zsh/ruby.zsh"
source "$HOME/.config/zsh/rust.zsh"
source "$HOME/.config/zsh/server.plugin.zsh"
source "$HOME/.fzf.zsh"
source "$HOME/.cargo/env"

# ╭──────────────────────╮
# │ https://starship.rs/ │
# ╰──────────────────────╯
eval "$(starship init zsh)"

alias tilt=/opt/homebrew/bin/tilt
source /Users/steve.loveless/.config/broot/launcher/bash/br

. <(zr zsh-users/zsh-syntax-highlighting.git/zsh-syntax-highlighting.plugin.zsh)

# source <(kubectl completion zsh)
# source <(rdctl completion zsh)

setopt appendhistory        # Immediately append history instead of overwriting
setopt auto_cd              # cd without `cd`
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt histignorealldups    # If a new command is a duplicate, remove the older one
setopt nobeep               # No beep
setopt numericglobsort      # Sort filenames numerically when it makes sense
setopt promptsubst
setopt vi

#------------------------------------------------------------------------------
# https://www.soberkoder.com/better-zsh-history/
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

#------------------------------------------------------------------------------

# ╭──────────────────────────────────────────────────────────────────────╮
# │ Completions; keep these towards the bottom in case other plugins add │
# │ completions to zsh/functions/.                                       │
# ╰──────────────────────────────────────────────────────────────────────╯
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"

  autoload -Uz compinit
  compinit
fi

install_completions() {
  . <(zr \
    ohmyzsh/ohmyzsh.git/plugins/cargo/_cargo \
    ohmyzsh/ohmyzsh.git/plugins/gem/_gem \
    ohmyzsh/ohmyzsh.git/plugins/rust/_rust \
    ohmyzsh/ohmyzsh.git/plugins/rustup/_rustup \
    ohmyzsh/ohmyzsh.git/plugins/chruby/chruby.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/git/git.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/rake-fast/rake-fast.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/tmux/tmux.plugin.zsh \
    ohmyzsh/ohmyzsh.git/plugins/docker-compose/docker-compose.plugin.zsh \
    zsh-users/zsh-autosuggestions.git/zsh-autosuggestions.plugin.zsh \
    zsh-users/zsh-completions.git/zsh-completions.plugin.zsh
  )
  eval "$(fnm completions --shell zsh)"
}
install_completions

zstyle ':completion:*' rehash true                              # automatically find new executables in path 
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker#settings
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcache

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

HISTFILESIZE=1000000
HISTSIZE=1000000
SAVEHIST=10000

export GPG_TTY=$(tty)

# ╭─────────╮
# │ vi-mode │
# ╰─────────╯
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
export VI_MODE_SET_CURSOR=true

# Bower
alias bower='noglob bower'

# ╭───────────────────────╮
# │ From zsh brew install │
# ╰───────────────────────╯
unalias run-help
autoload run-help
export HELPDIR=$HOMEBREW_PREFIX/share/zsh/help

# ╭────────╮
# │ Docker │
# ╰────────╯
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

# export PATH=$PATH:~/.local/share/nvim/mason/bin

# ╭──────╮
# │ pnpm │
# ╰──────╯
export PNPM_HOME="/Users/steve.loveless/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ╭──────────────────────────────╮
# │ # Final environment settings │
# ╰──────────────────────────────╯
export EDITOR=nvim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="$HOMEBREW_PREFIX/opt/binutils/bin:/usr/local/bin:$PATH"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/steve.loveless/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
