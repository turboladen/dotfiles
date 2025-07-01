-- Dependencies to install:
-- lua-language-server: brew install lua-language-server
-- stylua: cargo install stylua (or brew install stylua)
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
      -- Configure Lua language server with Neovim-specific settings
      vim.lsp.config("lua_ls", {
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

  -- Lua formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      formatters = {
        stylua = {
          condition = function(self, ctx)
            return vim.fs.find(
              { "stylua.toml", ".stylua.toml" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
      },
    },
  },
}
