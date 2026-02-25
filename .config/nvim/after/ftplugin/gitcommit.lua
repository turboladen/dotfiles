-- Git commit message settings
vim.bo.textwidth = 72
vim.wo.colorcolumn = "50,72"
vim.wo.spell = true
vim.wo.wrap = true
vim.wo.linebreak = true

-- Start in insert mode if the commit message is empty
if vim.fn.getline(1) == "" then
  vim.cmd("startinsert")
end
