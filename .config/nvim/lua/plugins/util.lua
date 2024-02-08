return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true
  },

  -- ╭──────────────────────────────────────────────────╮
  -- │  Enable repeating supported plugin maps with '.' │
  -- ╰──────────────────────────────────────────────────╯
  {
    "tpope/vim-repeat",
    event = "VeryLazy"
  },

  -- ╭───────────────────────────────────────────────────────────────────────────╮
  -- │ Open the current word with custom openers, GitHub shorthands for example. │
  -- ╰───────────────────────────────────────────────────────────────────────────╯
  {
    'ofirgall/open.nvim',
    event = "VeryLazy",
    dependencies = {
      'nvim-lua/plenary.nvim',
      "stevearc/dressing.nvim",
      -- Opener of open.nvim that opens shorthands of Jira tickets, E.g: JRASERVER-63928.
      {
        'ofirgall/open-jira.nvim',
        lazy = true,
        dependencies = { 'ofirgall/open.nvim' },
        opts = {
          url = "https://telusagriculture.atlassian.net/browse/"
        },
      }
    },
    config = function(_, opts)
      require("open").setup(opts)
      vim.keymap.set('n', 'gx', require("open").open_cword, { desc = "Try to open thing under cursor" })
    end
  },
}
