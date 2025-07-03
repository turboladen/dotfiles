-- SQL-specific settings
-- This file is sourced after LSP initializes for SQL files

-- SQL-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "-- %s"

-- SQL-specific window settings
vim.wo.wrap = false

-- SQL editing is handled by sqlls LSP
