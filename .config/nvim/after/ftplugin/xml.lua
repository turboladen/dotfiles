-- XML-specific settings
-- This file is sourced after LSP initializes for XML files

-- XML-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "<!-- %s -->"

-- XML-specific window settings
vim.wo.wrap = false

-- XML editing is handled by lemminx LSP
