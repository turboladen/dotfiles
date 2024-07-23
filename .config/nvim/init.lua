-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │                                                                              │
-- │                                   init.lua                                   │
-- │                                                                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('user.variables')
load('user.options')
load('user.commands')
require('user.lazy_init')

load('user.keymaps')

-- pcall(vim.cmd.colorscheme, 'nightfox')
pcall(vim.cmd.colorscheme, 'everforest')
-- pcall(vim.cmd.colorscheme, 'onedark_dark')
-- pcall(vim.cmd.colorscheme, 'material')
-- pcall(vim.cmd.colorscheme, 'aurora')

Rg2 = function(arg)
  local output = require("init_rs").ripgrep.rg_to_quick_fix(arg.fargs[1])
  vim.api.nvim_call_function("setqflist", { output })
  vim.api.nvim_command("copen")
end

vim.api.nvim_create_user_command("Rg2", Rg2, { nargs = 1 })
