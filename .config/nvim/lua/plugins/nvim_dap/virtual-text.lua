-- ╭────────────────────────────────────────────────────╮
-- │ This plugin adds virtual text support to nvim-dap. │
-- ╰────────────────────────────────────────────────────╯
local Plugin = { "theHamsta/nvim-dap-virtual-text" }

Plugin.enabled = false
Plugin.event = "VeryLazy"

Plugin.dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "mfussenegger/nvim-dap",
}

Plugin.opts = { commented = true }

return Plugin
