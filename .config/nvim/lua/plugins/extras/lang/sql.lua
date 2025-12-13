-- Dependencies to install:
-- sql-language-server: bun add -g sql-language-server
-- sqlfluff: pip install sqlfluff

return {
  -- Treesitter SQL parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "sql" },
    },
  },

  -- SQL LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure sqlls (uses lspconfig defaults)
      vim.lsp.config("sqlls", {})

      vim.lsp.enable("sqlls")
    end,
  },

  -- SQL formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
      formatters = {
        sqlfluff = {
          args = { "format", "--dialect=ansi", "-" },
        },
      },
    },
  },
}
