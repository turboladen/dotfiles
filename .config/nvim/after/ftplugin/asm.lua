-- Assembly-specific settings
-- This file is sourced after LSP initializes for Assembly files

-- Assembly-specific buffer settings
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = false -- Assembly often uses tabs
vim.bo.commentstring = "; %s"

-- Assembly-specific window settings
vim.wo.wrap = false

-- Assembly editing is handled by asm-lsp LSP
