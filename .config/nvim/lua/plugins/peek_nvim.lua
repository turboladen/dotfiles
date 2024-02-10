-- ╭────────────────────────────────────╮
-- │ Markdown preview plugin for Neovim │
-- ╰────────────────────────────────────╯
local Plugin = { 'toppair/peek.nvim' }

Plugin.build = 'deno task --quiet build:fast'
Plugin.ft = { "markdown" }
Plugin.event = "VeryLazy"
Plugin.config = function()
  local peek = require("peek")
  peek.setup({})

  vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
  vim.api.nvim_create_user_command('PeekClose', peek.close, {})
end

return Plugin
