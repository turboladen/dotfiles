return {
  -- ╭────────────────────────────────────────────────╮
  -- │ Plugin for calling lazygit from within neovim. │
  -- ╰────────────────────────────────────────────────╯
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig" },
  },

  {
    "brneor/gitui.nvim",
    enabled = false,
    keys = {
      { "<leader>gg", "<cmd>GitUi<cr>",       desc = "gitui" },
      { "<leader>gc", "<cmd>GitUiConfig<cr>", desc = "gitui config" }
    }
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim"
    },
    opts = function()
      local nf_fa_folder = ""
      local nf_fa_folder_open = ""

      return {
        signs = {
          section = { nf_fa_folder, nf_fa_folder_open },
          item = { nf_fa_folder, nf_fa_folder_open }
        },
        integrations = {
          diffview = true
        },
        use_telescope = true,
      }
    end,
    -- keys = {
    --   { "<leader>gg", "<cmd>Neogit kind=split<cr>", desc = "gitui" },
    -- }
  }
}
