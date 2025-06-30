return {
  -- Enhanced repeat functionality for plugin mappings
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },

  -- Git integration with lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- Optional for floating window border decoration
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open lazygit" },
    },
    config = function()
      -- Configure lazygit floating window appearance
      vim.g.lazygit_floating_window_winblend = 0 -- No transparency
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 90% of screen size
      vim.g.lazygit_floating_window_use_plenary = 1 -- Use plenary for better borders
      vim.g.lazygit_use_neovim_remote = 1 -- Enable neovim-remote integration if available
    end,
  },

  -- Smart opener for URLs, GitHub shorthands, etc.
  {
    "ofirgall/open.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "gx",
        function()
          require("open").open_cword()
        end,
        desc = "Open item under cursor",
      },
    },
    config = function()
      require("open").setup({
        -- Use default configuration
      })
    end,
  },

  -- Jira ticket opener extension for open.nvim
  {
    "ofirgall/open-jira.nvim",
    dependencies = {
      "ofirgall/open.nvim",
    },
    config = function()
      require("open-jira").setup({
        -- string|function(shorthand: string): string
        url = "https://telusagriculture.atlassian.net/browse/",
      })
    end,
  },
}
