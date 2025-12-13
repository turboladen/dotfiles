-- Dependencies to install:
-- yaml-language-server: bun add -g yaml-language-server
-- yamllint: pip install yamllint or brew install yamllint
-- dprint: curl -fsSL https://dprint.dev/install.sh | sh (with pretty_yaml plugin)

return {
  -- Treesitter YAML parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "yaml" },
    },
  },

  -- Schema store for YAML validation
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- YAML LSP configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/SchemaStore.nvim",
    },
    opts = function()
      -- Configure yamlls with SchemaStore integration
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = {
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      vim.lsp.enable("yamlls")
    end,
  },

  -- YAML formatting via conform.nvim
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        yaml = { "dprint" },
        yml = { "dprint" },
      },
    },
  },

  -- YAML linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      -- Add YAML linters to existing configuration
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.yaml = { "yamllint" }
      opts.linters_by_ft.yml = { "yamllint" }
      return opts
    end,
  },
}
