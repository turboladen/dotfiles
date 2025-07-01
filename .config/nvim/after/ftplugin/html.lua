-- HTML-specific settings
-- This file is sourced after LSP initializes for HTML files

-- HTML-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "<!-- %s -->"

-- HTML-specific window settings
vim.wo.wrap = true
vim.wo.linebreak = true

-- HTML editing is handled by html LSP with embedded CSS/JS support
