-- Dependencies to install:
-- ruby-lsp: gem install ruby-lsp
-- Note: vim-rails, vim-rake, vim-rbs, vim-projectionist, and vim-ruby are installed via plugin manager

return {
  -- Treesitter Ruby parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "ruby" },
    },
  },

  -- Ruby LSP configuration
  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- Most configuration is provided by nvim-lspconfig defaults
      -- We just need to enable the server and optionally override settings
      -- Configure ruby_lsp server with additional root markers
      vim.lsp.config("ruby_lsp", {
        root_markers = {
          "Gemfile",
          ".git",
          ".ruby-version",
          "config.ru",
          "Rakefile",
        },
      })

      vim.lsp.enable("ruby_lsp")
    end,
  },

  -- Rails support and project navigation
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby", "haml", "slim" },
    dependencies = {
      "tpope/vim-projectionist", -- Required for some Rails functionality
      "tpope/vim-rake", -- Rake support
    },
  },

  -- Enhanced Rake support
  {
    "tpope/vim-rake",
    ft = { "ruby" },
  },

  -- Ruby signature/type support (RBS)
  {
    "turboladen/vim-rbs",
    ft = { "rbs" },
  },

  -- Projectionist for better project navigation
  {
    "tpope/vim-projectionist",
    ft = { "ruby", "eruby", "haml", "slim" },
  },

  -- Enhanced Ruby support for better indentation and text objects
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby", "eruby" },
    init = function()
      -- Disable expensive operations to avoid conflicts with treesitter
      vim.g.ruby_no_expensive = 1
      -- Enable helpful features
      vim.g.ruby_operators = 1
      vim.g.ruby_space_errors = 1
      vim.g.ruby_fold = 1 -- Enable vim-ruby's Ruby-aware folding
    end,
  },

  -- Ruby linting configuration
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.ruby = { "ruby" }
      return opts
    end,
  },
}
