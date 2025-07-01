-- Dependencies to install:
-- sql-language-server: npm install -g sql-language-server

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
}
