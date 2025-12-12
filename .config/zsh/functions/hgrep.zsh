# ╭───────────────────────────────────────────────╮
# │ History grep - search shell history with rg  │
# ╰───────────────────────────────────────────────╯
hgrep() {
  history | rg -N "$1"
}
