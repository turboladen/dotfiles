vim.g.lua_syntax_fancynotequal = 1

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
      },
    },
  },
  { import = "plugins.lang.rust" },
}
