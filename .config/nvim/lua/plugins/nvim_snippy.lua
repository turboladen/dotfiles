--  ╭──────────────────────────────────────────╮
--  │ Snippet plugin for Neovim written in Lua │
--  ╰──────────────────────────────────────────╯
local Plugin = { "dcampos/nvim-snippy" }

Plugin.event = "VeryLazy"
Plugin.dependencies = { "honza/vim-snippets" }

Plugin.opts = {
  mappings = {
    is = {
      ['<Tab>'] = 'expand_or_advance',
      ['<S-Tab>'] = 'previous',
    },
    nx = {
      ['<leader>x'] = 'cut_text',
    },
  },
}

return Plugin
