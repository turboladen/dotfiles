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
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Git: Open lazygit" },
    },
    config = function()
      -- Configure lazygit floating window appearance
      vim.g.lazygit_floating_window_winblend = 0 -- No transparency
      vim.g.lazygit_floating_window_scaling_factor = 0.9 -- 90% of screen size
      vim.g.lazygit_floating_window_use_plenary = 1 -- Use plenary for better borders
      vim.g.lazygit_use_neovim_remote = 1 -- Enable neovim-remote integration if available
    end,
  },

  -- Keymap conflict analyzer (dev plugin)
  {
    "turboladen/keymap-analyzer.nvim",
    dev = true,
    dir = vim.fn.stdpath("config") .. "/lua/dev/keymap-analyzer.nvim",
    dependencies = {
      "ibhagwan/fzf-lua", -- For display functionality
    },
    keys = {
      {
        "<leader>pk",
        function()
          require("keymap-analyzer.fzf").show_duplicates()
        end,
        desc = "Pkg: Check keymaps",
      },
      {
        "<leader>pK",
        function()
          require("keymap-analyzer.fzf").show_all()
        end,
        desc = "Pkg: All keymaps",
      },
      {
        "<leader>ps",
        function()
          require("keymap-analyzer.fzf").show_stats()
        end,
        desc = "Pkg: Keymap stats",
      },
    },
    config = function()
      -- Create user commands for keymap utilities
      vim.api.nvim_create_user_command("KeymapDuplicates", function()
        require("keymap-analyzer.fzf").show_duplicates()
      end, { desc = "Find duplicate keymaps across config" })

      vim.api.nvim_create_user_command("KeymapAll", function()
        require("keymap-analyzer.fzf").show_all()
      end, { desc = "Show all keymaps in config" })

      vim.api.nvim_create_user_command("KeymapStats", function()
        require("keymap-analyzer.fzf").show_stats()
      end, { desc = "Show keymap statistics" })
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
        desc = "Open: Item under cursor",
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

  -- Dependency analyzer (dev plugin)
  {
    "turboladen/dependency-analyzer.nvim",
    dev = true,
    dir = vim.fn.stdpath("config") .. "/lua/dev/dependency-analyzer.nvim",
    keys = {
      {
        "<leader>pd",
        "<cmd>DepsCheck<cr>",
        desc = "Pkg: Check dependencies",
      },
      {
        "<leader>pD",
        "<cmd>DepsMissing<cr>",
        desc = "Pkg: Missing dependencies",
      },
      {
        "<leader>pi",
        "<cmd>DepsInstall<cr>",
        desc = "Pkg: Install script",
      },
    },
    config = function()
      -- Create user commands for dependency utilities
      vim.api.nvim_create_user_command("DepsCheck", function()
        require("dependency-analyzer.builtin").show_summary()
      end, { desc = "Quick dependency status check" })

      vim.api.nvim_create_user_command("DepsMissing", function()
        require("dependency-analyzer.builtin").show_missing()
      end, { desc = "Show missing dependencies in detail" })

      vim.api.nvim_create_user_command("DepsInstall", function()
        require("dependency-analyzer.builtin").show_install_commands()
      end, { desc = "Generate install script for missing dependencies" })

      vim.api.nvim_create_user_command("DepsReport", function()
        require("dependency-analyzer.builtin").show_full_report()
      end, { desc = "Show full dependency analysis report" })

      vim.api.nvim_create_user_command("DepsData", function()
        local analyzer = require("dependency-analyzer")
        local data = analyzer.get_data()
        vim.notify(vim.inspect(data), vim.log.levels.INFO)
      end, { desc = "Show raw dependency data" })
    end,
  },
}
