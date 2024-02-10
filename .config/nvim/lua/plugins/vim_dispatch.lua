-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Asynchronous build and test dispatcher. Used for running specs in a      │
-- │ separate tmux pane.                                                      │
-- ╰──────────────────────────────────────────────────────────────────────────╯
local Plugin = { "tpope/vim-dispatch" }

Plugin.cmd = {
  "AbortDispatch",
  "Copen",
  "Dispatch",
  "FocusDispatch",
  "Make",
  "Spawn",
  "Start",
}

Plugin.init = function()
  vim.g.dispatch_no_maps = 1
end

return Plugin
