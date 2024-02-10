-- ╭───────────────────────────────────────────────────────────────────────────╮
-- │ Open the current word with custom openers, GitHub shorthands for example. │
-- ╰───────────────────────────────────────────────────────────────────────────╯
local Plugin = { 'ofirgall/open.nvim' }

Plugin.event = "VeryLazy"
Plugin.dependencies = {
  'nvim-lua/plenary.nvim',
  require("plugins.telescope_ui_select_nvim"),
  -- Opener of open.nvim that opens shorthands of Jira tickets, E.g: JRASERVER-63928.
  {
    'ofirgall/open-jira.nvim',
    lazy = true,
    dependencies = { 'ofirgall/open.nvim' },
    opts = {
      url = "https://telusagriculture.atlassian.net/browse/"
    },
  }
}
Plugin.opts = {}

return Plugin
