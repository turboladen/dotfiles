# I do `history | grep [something]` all the time...
hgrep() {
  history | rg -N "$1"
}
