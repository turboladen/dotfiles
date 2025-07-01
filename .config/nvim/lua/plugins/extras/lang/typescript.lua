-- Dependencies to install:
-- typescript-language-server: npm install -g typescript-language-server typescript
-- vscode-eslint-language-server: npm install -g vscode-langservers-extracted
-- eslint: npm install -g eslint

return {
  -- Treesitter TypeScript parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typescript", "tsx", "javascript", "jsdoc" },
    },
  },

  -- TypeScript LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure TypeScript language server with inlay hints
      vim.lsp.config("ts_ls", {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- Configure ESLint language server (uses lspconfig defaults)
      vim.lsp.config("eslint", {})

      vim.lsp.enable("ts_ls")
      vim.lsp.enable("eslint")
    end,
  },

  -- TypeScript linting with eslint
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Add TypeScript linters to existing configuration
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.typescript = { "eslint" }
      opts.linters_by_ft.typescriptreact = { "eslint" }
      opts.linters_by_ft.javascript = { "eslint" }
      opts.linters_by_ft.javascriptreact = { "eslint" }
      return opts
    end,
  },
}
