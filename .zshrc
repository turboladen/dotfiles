# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# I like these
#ZSH_THEME="avit"         # double. left0: path | git info.  right0: return code
#ZSH_THEME="bira"         # double. left0: user@host | path | git info.  right: return code
#ZSH_THEME="bureau"       # double. left0: user@host | path.  right0: time.  right1: git info
#ZSH_THEME="clean"        # single. left: user | cwd | git info.  right: time
#ZSH_THEME="fishy"        # single. left: user@host | short path.  right: return code | git info
#ZSH_THEME="gallois"      # single. left: path.  right: git info | ruby version
#ZSH_THEME="gnzh"         # double. left0: user@host | path | git info.  right0: return code.
#ZSH_THEME="jnrowe"       # single. left: return code | relative path | git stuff.
#ZSH_THEME="mh"           # single. left: user | path.  right: git info
#ZSH_THEME="mrtazz"       # single. left: host | path.  right: git info
#ZSH_THEME="miloshadzic"  # single. left: dir | git info.
#ZSH_THEME="robbyrussell" # single. left: path | git info.
#ZSH_THEME="smt"          # double. left0: host | path | gitinfo.  right0: return code | time.  left1: prompt #
#ZSH_THEME="sorin"         # single. left: dir | gitinfo. right: return code
ZSH_THEME="turboladen"         # single. left: dir | gitinfo. right: return code
#ZSH_THEME="trapd00r"
#ZSH_THEME="wedisagree"   # single. left: path.  right: time (return coloring), git infographics
#ZSH_THEME="wezm"         # single. left: git info | return code. right: path

# These are meh
#ZSH_THEME="arrow"        # single. left: path.  right: git info
#ZSH_THEME="eastwood"     # single. left: git info | path
#ZSH_THEME="funky"
#ZSH_THEME="gallifrey"    # single. left: host | short path | git info.  right: return code
#ZSH_THEME="juanghurtado" # double. left: user@host | relative path. right: git stuff.
#ZSH_THEME="kolo"         # single. left: dir | git info.
#ZSH_THEME="kphoen"       # double. left: user@host | relative path | git info.  right: return code
#ZSH_THEME="mortalscumbag"   # double. left0: user@host | git info | path. left1: return code
#ZSH_THEME="nicoulaj"      # single. left: >. right: path/gitinfo
#ZSH_THEME="rkj-repos"
#ZSH_THEME="zhann"
#ZSH_THEME="ys"

# Example aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"
# setopt correct_all

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git myrails brew server chruby nyan rake-fast hgrep)
#plugins=(git rails brew server rbenv nyan rake-fast hgrep bundler gem git-hubflow redis-cli vi-mode web-search)
# plugins=(git myrails brew server chruby nyan rake-fast hgrep gem git-hubflow redis-cli history-substring-search)
plugins=(git myrails brew chruby rake-fast hgrep gem git-hubflow redis-cli server vi-mode mix-fast)

source $ZSH/oh-my-zsh.sh

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Add customizations below
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Make sure homebrew commands come first
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:$PATH

# Get access to Sublime's executables
export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin

# Add personal tmux commands
export PATH=$PATH:~/Development/projects/config_files/tmux

# Node
export PATH=$PATH:/usr/local/share/npm/bin

# Local bin
export PATH=$PATH:~/bin

# Bower
alias bower='noglob bower'

#------------------------------------------------------------------------------
# `brew install git`
#------------------------------------------------------------------------------
source /usr/local/share/zsh/site-functions

source ~/.chruby.zsh

#------------------------------------------------------------------------------
# chbundle
#------------------------------------------------------------------------------
# source ~/Development/projects/chbundle/share/chbundle.sh

#------------------------------------------------------------------------------
# `brew install z`
#------------------------------------------------------------------------------
source `brew --prefix`/etc/profile.d/z.sh

#------------------------------------------------------------------------------
# `brew install zsh-syntax-highlighting
#------------------------------------------------------------------------------
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#------------------------------------------------------------------------------
# `brew install zsh-history-substring-search
#------------------------------------------------------------------------------
source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh

# bind UP and DOWN arrow keys
# zmodload zsh/terminfo
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Final environment settings
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

# Append PWD/bin to the path for Rails projects
# export PATH=$PATH:./bin

export EDITOR=nvim
# set -o vi
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export VMAIL_HTML_PART_READER='elinks -dump'

# https://github.com/rweng/pry-rails
export DISABLE_PRY_RAILS=1

# Fix openssl related shared library builds for rust
export OPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include
export OPENSSL_ROOT_DIR=/usr/local/opt/openssl
export OPENSSL_LIB_DIR=/usr/local/opt/openssl/lib

# From zsh brew install
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

export HOMEBREW_GITHUB_API_TOKEN=d285305a2b71152ab74e89158f577d0221184804

# ansible
ANSIBLE_HOSTS="~/.config/ansible/hosts"

#--------------------------------------------------------------------
# fzf things
#--------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# From:
# https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2#.p7o8p2q5z
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor/bundle,target,doc}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# bind -x '"\C-p": vim $(fzf);'

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  zmodload zsh/mapfile

  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    # mapfile -t out <<< "$out"
    $mapfile[out] <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%%}"

    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

unalias z 2> /dev/null
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _z "$@"
  fi
}


# chruby integreation
frb() {
  local rb
  rb=$((echo system; chruby | cut -c 4-) |
      awk '{print $1}' |
      fzf-tmux -l 30 +m --reverse)
  chruby $rb
}

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

PATH="/Users/sloveless/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/sloveless/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/sloveless/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/sloveless/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/sloveless/perl5"; export PERL_MM_OPT;

# alias ll="ls -lAG"
alias ll="exa -la"
export PATH="/usr/local/opt/node@6/bin:$PATH"

# For rustup, completions
fpath+=~/.zfunc
compinit


PATH=$PATH:/Users/sloveless/.emsdk/emscripten/1.37.22
