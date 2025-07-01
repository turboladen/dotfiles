-- Dependencies to install:
-- lua-language-server: brew install lua-language-server
-- Note: lazydev.nvim and luvit-meta are installed via plugin manager

return {
  -- Treesitter Lua parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "luadoc", "luap" },
    },
  },

  -- Lua LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Additional lua configuration, makes nvim stuff amazing!
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
    },
    opts = function()
      -- Configure Lua language server
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })

      -- Enable lua_ls
      vim.lsp.enable("lua_ls")
    end,
  },
}
