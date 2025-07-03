-- C++-specific settings
-- This file is sourced after LSP initializes for C++ files

-- C++-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "// %s"

-- C++-specific window settings
vim.wo.wrap = false

-- C++ editing is handled by clangd LSP and clangd_extensions
