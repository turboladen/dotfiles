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
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# bind k and j for VI mode
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
# Final environment settings
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
export EDITOR=nvim
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# From zsh brew install
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

#--------------------------------------------------------------------
# Ruby
#--------------------------------------------------------------------
source ~/.oh-my-zsh/custom/ruby.zsh

#--------------------------------------------------------------------
# Rust
#--------------------------------------------------------------------
source ~/.oh-my-zsh/custom/rust.zsh
export HOMEBREW_GITHUB_API_TOKEN=d285305a2b71152ab74e89158f577d0221184804

#--------------------------------------------------------------------
# ansible
#--------------------------------------------------------------------
source ~/.oh-my-zsh/custom/ansible.zsh

#--------------------------------------------------------------------
# fzf
#--------------------------------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source ~/.oh-my-zsh/custom/fzf.zsh

#--------------------------------------------------------------------
# iTerm
#--------------------------------------------------------------------
source ~/.oh-my-zsh/custom/iterm.zsh

#--------------------------------------------------------------------
# emscripten
#--------------------------------------------------------------------
PATH=$PATH:/Users/sloveless/.emsdk/emscripten/1.37.22

# Keep this towards the end so other things can prep
compinit
