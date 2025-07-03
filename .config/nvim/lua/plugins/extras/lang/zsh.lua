-- Dependencies to install:
-- bash-language-server: npm install -g bash-language-server
-- shfmt: go install mvdan.cc/sh/v3/cmd/shfmt@latest (or brew install shfmt)

return {
  -- Treesitter parser (zsh uses bash parser)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "bash" },
    },
  },

  -- Zsh LSP configuration (using bashls)
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure bashls for Zsh files
      vim.lsp.config("bashls", {
        filetypes = { "bash", "sh", "zsh" },
      })

      vim.lsp.enable("bashls")
    end,
  },

  -- Zsh linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.zsh = { "zsh" }
      return opts
    end,
  },

  -- Zsh formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        zsh = { "shfmt" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
      },
    },
  },
}
