#------------------------------------------------------------------------------
# Make chruby rubies available when using from non-interactive sessions (ex.
# from vim)
#
# `brew install chruby ruby-install`
#------------------------------------------------------------------------------
brew_prefix=/usr/local

if [[ -f $brew_prefix/opt/chruby/share/chruby/chruby.sh ]]; then
  source $brew_prefix/opt/chruby/share/chruby/chruby.sh
  chruby "2.7.3"
  source $brew_prefix/opt/chruby/share/chruby/auto.sh
else
  echo "chruby not found."
fi
