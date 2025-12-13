-- Dependencies to install:
-- docker-langserver: bun add -g dockerfile-language-server-nodejs

return {
  -- Treesitter Dockerfile parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "dockerfile" },
    },
  },

  -- Docker LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure dockerls (uses lspconfig defaults)
      vim.lsp.config("dockerls", {})

      vim.lsp.enable("dockerls")
    end,
  },
}
