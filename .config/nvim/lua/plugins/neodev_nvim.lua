-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃         💻 Neovim setup for init.lua and plugin          ┃
-- ┃      development with full signature help, docs and      ┃
-- ┃             completion for the nvim lua API.             ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
local Plugin = { "folke/neodev.nvim" }

Plugin.event = "VeryLazy"
Plugin.opts = {
  library = {
    plugins = { "neotest" },
    types = true
  },
}

return Plugin
