# ╭──────────────────────────╮
# │ Interactive Shell Config │
# ╰──────────────────────────╯

# ╭─────────────────────╮
# │ Shell configuration │
# ╰─────────────────────╯
setopt appendhistory           # Immediately append history instead of overwriting
setopt auto_cd                 # cd without `cd`
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt histignorealldups       # If a new command is a duplicate, remove the older one
setopt nobeep                  # No beep
setopt numericglobsort         # Sort filenames numerically when it makes sense
setopt promptsubst
setopt vi

# Better zsh history - https://www.soberkoder.com/better-zsh-history/
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

HISTFILESIZE=1000000
HISTSIZE=1000000
SAVEHIST=10000

# ╭──────────────────────────────────────────────────────────────────────╮
# │ Initialize completions BEFORE loading plugins                        │
# ╰──────────────────────────────────────────────────────────────────────╯
if type brew &>/dev/null; then
  FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:$FPATH"
  autoload -Uz compinit
  compinit
fi

# Automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# ╭────────────────────────────────╮
# │ Auto-source tool configs       │
# │ (fish-style conf.d pattern)    │
# ╰────────────────────────────────╯
if [[ -d "$HOME/.config/zsh/conf.d" ]]; then
  for conf in "$HOME/.config/zsh/conf.d"/*.zsh; do
    [[ -f "$conf" ]] && source "$conf"
  done
fi

# ╭──────────────────────────╮
# │ Install plugins using zr │
# ╰──────────────────────────╯
source "$HOME/.config/zsh/zr/interactive.zsh"

# Load additional completions via zr
source "$HOME/.config/zsh/zr/completions.zsh"

# Completion styling
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcache

# ╭───────────────╮
# │ Tool setup    │
# ╰───────────────╯
unalias run-help 2>/dev/null
autoload run-help
export HELPDIR="$HOMEBREW_PREFIX/share/zsh/help"

# ╭────────────────────╮
# │ Custom Functions   │
# ╰────────────────────╯
if [[ -d "$HOME/.config/zsh/functions" ]]; then
  for func in "$HOME/.config/zsh/functions"/*.zsh; do
    [[ -f "$func" ]] && source "$func"
  done
fi
