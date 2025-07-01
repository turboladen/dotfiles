-- JavaScript-specific settings
-- This file is sourced after LSP initializes for JavaScript files

-- JavaScript-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "// %s"

-- JavaScript-specific window settings
vim.wo.wrap = false

-- JavaScript editing is handled by ts_ls and eslint LSPs
