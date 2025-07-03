-- JSON-specific settings and keymaps
-- This file is sourced after LSP initializes for JSON files

local bufnr = vim.api.nvim_get_current_buf()

-- JSON-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "// %s"

-- JSON-specific window settings
vim.wo.wrap = false
vim.wo.conceallevel = 0 -- Don't hide quotes in JSON
