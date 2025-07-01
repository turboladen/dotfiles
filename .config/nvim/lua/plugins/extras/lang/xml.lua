-- Dependencies to install:
-- lemminx: Download from https://github.com/redhat-developer/vscode-xml/releases

return {
  -- Treesitter XML parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "xml" },
    },
  },

  -- XML LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure lemminx (uses lspconfig defaults)
      vim.lsp.config("lemminx", {})

      vim.lsp.enable("lemminx")
    end,
  },
}
