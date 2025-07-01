-- Dependencies to install:
-- terraform-ls: https://github.com/hashicorp/terraform-ls/releases
-- terraform: brew install terraform
-- tflint: brew install tflint

return {
  -- Treesitter HCL parser (used for Terraform)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "hcl", "terraform" },
    },
  },

  -- Terraform LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Configure terraform-ls (uses lspconfig defaults)
      vim.lsp.config("terraformls", {})

      vim.lsp.enable("terraformls")
    end,
  },

  -- Terraform linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.terraform = { "terraform_validate", "tflint" }
      opts.linters_by_ft.hcl = { "terraform_validate" }
      return opts
    end,
  },

  -- Terraform formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
      },
    },
  },
}
