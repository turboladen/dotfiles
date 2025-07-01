-- Dependencies to install:
-- ruff: pip install ruff or brew install ruff
-- pyright: npm install -g pyright

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
      -- Configure ruff LSP server for linting and formatting
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

      -- Configure pyright for semantic analysis, go-to-definition, etc.
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
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
          pyright = {
            disableOrganizeImports = true, -- Let ruff handle imports
          },
          python = {
            analysis = {
              ignore = { "*" }, -- Disable pyright diagnostics, let ruff handle them
              typeCheckingMode = "basic",
            },
          },
        },
      })

      vim.lsp.enable("ruff")
      vim.lsp.enable("pyright")
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
