-- Fish Shell Language Support
-- Dependencies:
--   - fish_lsp: brew install fish-lsp
--   - fish_indent: included with fish shell
--   - fish: fish shell itself for syntax checking
--   - Treesitter: fish parser

return {
  -- Treesitter Configuration
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "fish" },
    },
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure fish_lsp
      vim.lsp.config("fish_lsp", {
        -- fish_lsp provides completion, diagnostics, and formatting
        -- Uses fish_indent for formatting by default
        -- No additional settings needed - defaults are good
      })

      -- Enable fish_lsp
      vim.lsp.enable("fish_lsp")
    end,
  },

  -- Fish linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.fish = { "fish" }
      return opts
    end,
  },

  -- Fish formatting via conform.nvim (fish_indent is preferred over LSP)
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
      },
      formatters = {
        fish_indent = {
          -- fish_indent is included with fish shell
          command = "fish_indent",
          args = {},
          stdin = true,
        },
      },
    },
  },

  -- Additional Fish support
  {
    "khaveesh/vim-fish-syntax",
    ft = "fish",
    -- Provides additional syntax highlighting and indentation
    -- that complements Treesitter and LSP
  },
}
