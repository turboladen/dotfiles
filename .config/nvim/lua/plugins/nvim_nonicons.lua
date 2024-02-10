-- ╭─────────────────────────────────────────────────────────╮
-- │ Icon set using nonicons for neovim plugins and settings │
-- ╰─────────────────────────────────────────────────────────╯
local Plugin = { "yamatsum/nvim-nonicons" }

Plugin.lazy = true

Plugin.dependencies = {
  require("plugins.nvim_web_devicons")
}

Plugin.opts = {}

return Plugin
