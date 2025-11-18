-- Starlark-specific settings
-- This file is sourced after LSP initializes for Starlark files

-- Starlark files use the same settings as Tiltfiles
-- Source the tiltfile ftplugin configuration
local tiltfile_ftplugin = vim.fn.stdpath("config") .. "/after/ftplugin/tiltfile.lua"
if vim.fn.filereadable(tiltfile_ftplugin) == 1 then
  dofile(tiltfile_ftplugin)
end
