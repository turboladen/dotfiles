-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Asynchronous build and test dispatcher. Used for running specs in a      │
-- │ separate tmux pane.                                                      │
-- ╰──────────────────────────────────────────────────────────────────────────╯
return {
  "tpope/vim-dispatch",
  cmd = {
    "AbortDispatch",
    "Copen",
    "Dispatch",
    "FocusDispatch",
    "Make",
    "Spawn",
    "Start",
  },
  init = function()
    vim.g.dispatch_no_maps = 1
  end
}
