-- TypeScript-specific settings
-- This file is sourced after LSP initializes for TypeScript files

-- TypeScript-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "// %s"

-- TypeScript-specific window settings
vim.wo.wrap = false

-- TypeScript editing is handled by ts_ls and eslint LSPs
