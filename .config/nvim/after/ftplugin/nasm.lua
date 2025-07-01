-- NASM-specific settings
-- This file is sourced after LSP initializes for NASM files

-- NASM files use the same settings as Assembly
-- Source the asm ftplugin configuration
local asm_ftplugin = vim.fn.stdpath("config") .. "/after/ftplugin/asm.lua"
if vim.fn.filereadable(asm_ftplugin) == 1 then
  dofile(asm_ftplugin)
end
