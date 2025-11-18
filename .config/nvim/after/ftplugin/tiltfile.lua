-- Tiltfile-specific settings
-- This file is sourced after LSP initializes for Tiltfile files

-- Tiltfile-specific buffer settings
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- Tiltfile-specific window settings
vim.wo.wrap = false

-- Tiltfile editing is handled by tilt_ls LSP
