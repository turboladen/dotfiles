-- Dependencies to install:
-- docker-langserver: npm install -g dockerfile-language-server-nodejs

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
      -- Configure dockerls server
      vim.lsp.config("dockerls", {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = {
          "Dockerfile",
          "docker-compose.yml",
          "docker-compose.yaml",
          ".dockerignore",
          ".git",
        },
        settings = {},
      })

      vim.lsp.enable("dockerls")
    end,
  },
}
