-- Dependencies to install:
-- just-lsp: cargo install just-lsp

return {
  -- Treesitter Just parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "just" },
    },
  },

  -- Just LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure just LSP (uses lspconfig defaults)
      vim.lsp.config("just", {})

      vim.lsp.enable("just")
    end,
  },
}
