-- ╭───────────────────────────────────────────────────────────────────────────╮
-- │ Open the current word with custom openers, GitHub shorthands for example. │
-- ╰───────────────────────────────────────────────────────────────────────────╯
return {
  {
    'ofirgall/open.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "stevearc/dressing.nvim"
    },
    config = function(_, opts)
      require("open").setup(opts)
      vim.keymap.set('n', 'gx', require("open").open_cword, { desc = "Try to open thing under cursor" })
    end
  },
  -- Opener of open.nvim that opens shorthands of Jira tickets, E.g: JRASERVER-63928.
  {
    'ofirgall/open-jira.nvim',
    dependencies = { 'ofirgall/open.nvim' },
    opts = {
      url = "https://telusagriculture.atlassian.net/browse/"
    },
  }
}
