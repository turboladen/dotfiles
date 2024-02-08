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

pcall(vim.cmd.colorscheme, 'nightfox')
