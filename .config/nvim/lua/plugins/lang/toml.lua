-- Dependencies to install:
-- taplo: cargo install taplo-cli --locked --features lsp
--
-- Note: No external formatter needed - taplo LSP includes excellent formatting

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
      -- Configure taplo with schema support
      vim.lsp.config("taplo", {
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
