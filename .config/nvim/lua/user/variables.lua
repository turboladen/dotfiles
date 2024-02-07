-- local function set_host_progs()
-- let node_host_path = '/Users/steve.loveless/.nvm/versions/node/v16.16.0/bin'
-- let $PATH = node_host_path . ':' . $PATH
-- let g:node_host_prog = node_host_path . '/node'
-- vim.g.node_host_prog = 'Users/steve.loveless/.nvm/versions/node/v16.16.0/lib/node_modules'
-- vim.g.python_host_prog = vim.g.turboladen_homebrew_prefix .. '/bin/python2'
-- vim.g.python3_host_prog = vim.g.turboladen_homebrew_prefix .. '/bin/python3'
-- end

-- set_host_progs()

-- ╭───────────────────────────────────────────────────╮
-- │ 0. Load special things before plugins stuff first │
-- ╰───────────────────────────────────────────────────╯
vim.g.loaded_perl_provider = 0

-- These need to be set before using `lazy`, but we need `which-key`, which
-- needs lazy to set keymaps.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
