-- TOML-specific settings and keymaps
-- This file is sourced after LSP initializes for TOML files

local bufnr = vim.api.nvim_get_current_buf()

-- TOML-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- TOML-specific window settings
vim.wo.wrap = false

-- TOML editing is handled by Taplo LSP
