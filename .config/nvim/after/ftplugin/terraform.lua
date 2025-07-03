-- Terraform-specific settings
-- This file is sourced after LSP initializes for Terraform files

-- Terraform-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "# %s"

-- Terraform-specific window settings
vim.wo.wrap = false

-- Terraform editing is handled by terraform-ls LSP
