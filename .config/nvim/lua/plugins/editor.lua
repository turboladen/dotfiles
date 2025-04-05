require("ts-comments").setup({})
require("todo-comments").setup({})

-- ╭────────────────────────────────╮
-- │ "vim-utils/vim-troll-stopper", │
-- ╰────────────────────────────────╯
vim.cmd([[highlight TrollStopper ctermbg = red guibg = #FF0000 ]])

-- ╭─────────────╮
-- │ vim-ripgrep │
-- ╰─────────────╯
vim.g.rg_command = "rg --vimgrep --ignore-vcs"

-- ╭──────────╮
-- │ goyo.vim │
-- ╰──────────╯
vim.g.goyo_width = 102

-- ╭────────────────────────────────────────────────────╮
-- │ Neovim plugin for splitting/joining blocks of code │
-- ╰────────────────────────────────────────────────────╯
require("treesj").setup({
  use_default_keymaps = false,
  max_join_length = 100,
})

-- require("user.commands").treesj()

-- local langs = require('treesj.langs')['presets']
--
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   group = vim.api.nvim_create_augroup('user_treesj_keymaps', { clear = true }),
--   pattern = '*',
--   callback = function()
--     require("user.keymaps").treesj(langs)
--   end
-- })

-- ╭─────────────╮
-- │ vim-matchup │
-- ╰─────────────╯
-- ╭───────────────────────────────────────────────────────────────────────╮
-- │ match-up is a plugin that lets you highlight, navigate, and operate   │
-- │ on sets of matching text. It extends vim's % key to language-specific │
-- │ words instead of just single characters.                              │
-- ╰───────────────────────────────────────────────────────────────────────╯
vim.g.matchup_surround_enabled = 1
vim.g.matchup_matchparen_offscreen = { method = "popup" }

-- require("nvim-treesitter.configs").setup({
-- matchup = {
-- enable = true,
-- }
-- })
