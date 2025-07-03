-- Zsh-specific settings
-- This file is sourced after LSP initializes for Zsh files

-- Zsh-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- Zsh-specific window settings
vim.wo.wrap = false

-- Zsh editing is handled by bashls LSP (Zsh-compatible)
