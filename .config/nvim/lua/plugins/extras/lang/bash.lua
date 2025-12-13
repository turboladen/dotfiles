-- Dependencies to install:
-- bash-language-server: bun add -g bash-language-server
-- shfmt: go install mvdan.cc/sh/v3/cmd/shfmt@latest (or brew install shfmt)

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
      -- Configure bashls with formatting disabled (shfmt handles formatting)
      vim.lsp.config("bashls", {
        settings = {
          bashIde = {
            -- Disable formatting since shfmt is superior
            formatting = false,
          },
        },
      })

      vim.lsp.enable("bashls")
    end,
  },

  -- Bash formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
  },
}
