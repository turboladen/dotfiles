-- Dependencies to install:
-- vscode-json-language-server: npm install -g vscode-langservers-extracted

return {
  -- Treesitter JSON parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "json", "json5", "jsonc" },
    },
  },

  -- Schema store for JSON validation
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- JSON LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/SchemaStore.nvim",
    },
    opts = function()
      -- Configure jsonls with SchemaStore integration
      -- Also, jsonls comes from vscode-json-language-server, provided by the vscode-langservers-extracted npm package
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      })

      vim.lsp.enable("jsonls")
    end,
  },

  -- JSON formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        json = { "dprint" },
        jsonc = { "dprint" },
      },
      formatters = {
        dprint = {
          condition = function(self, ctx)
            return vim.fs.find(
              { "dprint.json", ".dprint.json", "dprint.jsonc" },
              { path = ctx.filename, upward = true }
            )[1]
          end,
        },
      },
    },
  },
}
