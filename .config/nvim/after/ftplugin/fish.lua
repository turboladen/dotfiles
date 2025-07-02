-- Fish shell-specific settings
-- This file is sourced after LSP initializes for Fish files

-- Fish-specific buffer settings
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- Fish-specific window settings
vim.wo.wrap = false

-- Fish editing is handled by fish_lsp LSP
-- Formatting is handled by fish_indent via conform.nvim
