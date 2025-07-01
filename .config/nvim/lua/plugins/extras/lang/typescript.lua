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
      -- Configure TypeScript language server
      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_markers = {
          "package.json",
          "tsconfig.json",
          "jsconfig.json",
          ".git",
        },
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

      -- Configure ESLint language server for linting and code actions
      vim.lsp.config("eslint", {
        cmd = { "vscode-eslint-language-server", "--stdio" },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_markers = {
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.json",
          "eslint.config.js",
          "package.json",
          ".git",
        },
        settings = {
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine",
            },
            showDocumentation = {
              enable = true,
            },
          },
          codeActionOnSave = {
            enable = false,
            mode = "all",
          },
          experimental = {
            useFlatConfig = false,
          },
          format = true,
          nodePath = "",
          onIgnoredFiles = "off",
          packageManager = "npm",
          problems = {
            shortenToSingleLine = false,
          },
          quiet = false,
          rulesCustomizations = {},
          run = "onType",
          useESLintClass = false,
          validate = "on",
          workingDirectory = {
            mode = "location",
          },
        },
      })

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
