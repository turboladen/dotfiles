-- Dependencies to install:
-- ruff: pip install ruff or brew install ruff
-- pyright: bun add -g pyright

return {
  -- Treesitter Python parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python", "toml" },
    },
  },

  -- Python LSP configuration with ruff and pyright
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure ruff LSP (uses lspconfig defaults)
      vim.lsp.config("ruff", {})

      vim.lsp.enable("ruff")
      vim.lsp.enable("ty")
    end,
  },

  -- Python linting with ruff
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Add Python linters to existing configuration
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.python = { "ruff" }
      return opts
    end,
  },
}
