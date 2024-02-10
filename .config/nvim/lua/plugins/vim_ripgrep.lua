-- ╭───────────────────────────────────────────────────────────╮
-- │ Use RipGrep in Vim and display results in a quickfix list │
-- ╰───────────────────────────────────────────────────────────╯
local Plugin = { "jremmen/vim-ripgrep" }

Plugin.cmd = "Rg"

Plugin.init = function()
  vim.g.rg_command = "rg --vimgrep --ignore-vcs"
  -- vim.g.rg_highlight = 1
end

return Plugin
