-- ╭────────────────────────────────────────────────────╮
-- │ Neovim plugin for splitting/joining blocks of code │
-- ╰────────────────────────────────────────────────────╯
local Plugin = { 'Wansmer/treesj' }

Plugin.event = "VeryLazy"

Plugin.dependencies = {
  require("plugins.nvim_treesitter"),
  -- ╭───────────────────────────────────────────╮
  -- │ Adds gS and gJ to split/join code blocks. │
  -- ╰───────────────────────────────────────────╯
  "AndrewRadev/splitjoin.vim",
}

Plugin.opts = {
  use_default_keymaps = false,
  max_join_length = 100,
}

Plugin.config = function(_, opts)
  require('treesj').setup(opts)
  require("user.commands").treesj()
end
return Plugin
