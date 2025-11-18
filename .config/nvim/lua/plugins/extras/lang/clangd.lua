-- Dependencies to install:
-- clangd: brew install llvm (or system package manager)
-- clang-tidy: included with clangd/llvm

return {
  -- Treesitter C/C++ parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "c", "cpp" },
    },
  },

  -- Clangd extensions for enhanced C/C++ support
  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function() end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },

  -- C/C++ LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "p00f/clangd_extensions.nvim",
    },
    opts = function()
      -- Configure clangd with enhanced command flags and options
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      })

      vim.lsp.enable("clangd")
    end,
  },

  -- C/C++ linting with clang-tidy
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.c = { "clangtidy" }
      opts.linters_by_ft.cpp = { "clangtidy" }
      return opts
    end,
  },
}
