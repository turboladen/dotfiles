--===========================================================================
-- https://github.com/olimorris/persisted.nvim
--===========================================================================
vim.o.sessionoptions = "buffers,curdir,folds,winpos,winsize"

require("persisted").setup({
  autoload = true,
  before_save = function()
    pcall(vim.cmd, ":Bdelete hidden")
    pcall(vim.cmd, ":TroubleClose")
  end,
  -- multiple sessions files for a given project, by using git branches
  use_git_branch = true,
})

 require("telescope").load_extension("persisted")
