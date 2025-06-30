return {
  -- Treesitter Python parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python", "toml" },
    },
  },

  -- Python LSP configuration with ruff
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure ruff LSP server
      vim.lsp.config("ruff", {
        cmd = { "ruff", "server", "--preview" },
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfig.json",
          ".git",
        },
        settings = {
          -- Ruff language server settings
          args = {},
        },
      })

      vim.lsp.enable("ruff")
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
