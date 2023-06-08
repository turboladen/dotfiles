-- ╭───────────────────────────────────────────────────────────╮
-- │ Use RipGrep in Vim and display results in a quickfix list │
-- ╰───────────────────────────────────────────────────────────╯
return {
  "jremmen/vim-ripgrep",
  cmd = "Rg",
  init = function()
    vim.g.rg_command = "rg --vimgrep --ignore-vcs"
    -- vim.g.rg_highlight = 1
  end
}
