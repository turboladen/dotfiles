-- HCL-specific settings
-- This file is sourced after LSP initializes for HCL files

-- HCL files use the same settings as Terraform
-- Source the terraform ftplugin configuration
local terraform_ftplugin = vim.fn.stdpath("config") .. "/after/ftplugin/terraform.lua"
if vim.fn.filereadable(terraform_ftplugin) == 1 then
  dofile(terraform_ftplugin)
end
