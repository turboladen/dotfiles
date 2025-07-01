-- Dependencies to install:
-- bash-language-server: npm install -g bash-language-server

return {
  -- Treesitter Bash parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "bash" },
    },
  },

  -- Bash LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure bashls (uses lspconfig defaults)
      vim.lsp.config("bashls", {})

      vim.lsp.enable("bashls")
    end,
  },
}
