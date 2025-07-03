-- Git rebase specific settings
-- This file is sourced when editing git rebase files

-- Git rebase specific buffer settings
vim.bo.commentstring = "# %s"
vim.wo.wrap = false
vim.wo.number = true
vim.wo.relativenumber = false

-- Position cursor on first commit line (skip comments) when entering buffer
vim.api.nvim_create_autocmd("BufEnter", {
  buffer = 0,
  callback = function()
    vim.fn.search("^[^#]", "w")
  end,
})
