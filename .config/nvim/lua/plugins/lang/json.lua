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
      -- Configure jsonls server
      vim.lsp.config("jsonls", {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = {
          "package.json",
          "tsconfig.json",
          ".git",
        },
        init_options = {
          provideFormatter = true,
        },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
            format = { enable = true },
          },
        },
      })

      vim.lsp.enable("jsonls")
    end,
  },
}
