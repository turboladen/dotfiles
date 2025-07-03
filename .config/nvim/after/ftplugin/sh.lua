-- Shell script-specific settings
-- This file is sourced after LSP initializes for shell script files

-- sh files use the same settings as bash
-- Source the bash ftplugin configuration
local bash_ftplugin = vim.fn.stdpath("config") .. "/after/ftplugin/bash.lua"
if vim.fn.filereadable(bash_ftplugin) == 1 then
  dofile(bash_ftplugin)
end
