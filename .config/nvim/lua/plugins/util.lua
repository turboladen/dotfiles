return {
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

  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },
}
