-- Dependencies to install:
-- dprint: brew install dprint

return {
  -- Treesitter parsers (dprint supports multiple languages)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "json", "jsonc", "markdown", "javascript", "typescript" },
    },
  },

  -- Dprint LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure dprint LSP (uses lspconfig defaults)
      vim.lsp.config("dprint", {})

      vim.lsp.enable("dprint")
    end,
  },
}
