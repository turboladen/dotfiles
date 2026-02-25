-- Python-specific settings
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"
vim.bo.textwidth = 88 -- Black/Ruff formatter default

vim.wo.colorcolumn = "88,120"

-- Useful abbreviations for debugging
vim.cmd([[iabbrev <buffer> pprint import pprint; pprint.pprint()]])
vim.cmd([[iabbrev <buffer> ipdb import ipdb; ipdb.set_trace()]])
vim.cmd([[iabbrev <buffer> pudb import pudb; pudb.set_trace()]])
