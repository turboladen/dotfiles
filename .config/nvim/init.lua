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


-- vim.cmd.colorscheme("nightfox")
-- vim.cmd.colorscheme("kanagawa")
-- vim.cmd.colorscheme("everforest")
-- vim.cmd.colorscheme("material")
-- vim.cmd.colorscheme("falcon")
-- vim.cmd.colorscheme("github_dark_default")
-- vim.cmd.colorscheme("kosmikoa")
-- vim.cmd.colorscheme("kuroi")
-- vim.cmd.colorscheme("nordbuddy")
-- vim.cmd.colorscheme("uwu")

-- vim.cmd([[setglobal expandtab]])
