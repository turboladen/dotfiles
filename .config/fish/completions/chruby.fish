set -l __chruby_rubies (string trim (string join ' ' (ls "$HOME/.rubies")))

complete --command chruby --no-files --arguments $__chruby_rubies -d 'Switch to this '
