return {
  -- Treesitter TOML parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "toml" },
    },
  },

  -- TOML LSP configuration with Taplo
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure taplo server
      vim.lsp.config("taplo", {
        cmd = { "taplo", "lsp", "stdio" },
        filetypes = { "toml" },
        root_markers = {
          "*.toml",
          "pyproject.toml",
          "Cargo.toml",
          ".git",
        },
        settings = {
          taplo = {
            schema = {
              enabled = true,
              catalogs = {
                "https://www.schemastore.org/api/json/catalog.json",
              },
            },
          },
        },
      })

      vim.lsp.enable("taplo")
    end,
  },
}
