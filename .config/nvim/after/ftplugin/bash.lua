-- Bash-specific settings
-- This file is sourced after LSP initializes for Bash files

-- Bash-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- Bash-specific window settings
vim.wo.wrap = false

-- Bash editing is handled by bashls LSP
