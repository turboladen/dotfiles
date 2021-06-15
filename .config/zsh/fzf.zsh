# Setup fzf
# ---------
# OLD command: rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor/bundle,target,doc}/*" 2> /dev/null
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden'

# if [[ ! "$PATH" == /Users/steve.loveless/.fzf/bin* ]]; then
#   export PATH="${PATH:+${PATH}:}/Users/steve.loveless/.fzf/bin"
# fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "/Users/steve.loveless/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
# source "/Users/steve.loveless/.fzf/shell/key-bindings.zsh"
# source "/Users/steve.loveless/.fzf/shell/completion.zsh"

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --header='[kill:process]' | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
