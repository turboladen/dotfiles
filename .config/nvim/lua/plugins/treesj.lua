-- ╭────────────────────────────────────────────────────╮
-- │ Neovim plugin for splitting/joining blocks of code │
-- ╰────────────────────────────────────────────────────╯
-- local Plugin = { 'Wansmer/treesj' }
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
