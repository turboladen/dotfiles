# Setup fzf
# ---------
# OLD command: rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor/bundle,target,doc}/*" 2> /dev/null<Paste>
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'

if [[ ! "$PATH" == */Users/sloveless/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/sloveless/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/sloveless/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/sloveless/.fzf/shell/key-bindings.zsh"
