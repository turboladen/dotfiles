--  ╭─────────────────────────────────────────────────────────────────────────╮
--  │ nvim-ts-context-commentstring: Neovim treesitter plugin for setting the │
--  │ commentstring based on the cursor location in a file.                   │
--  ╰─────────────────────────────────────────────────────────────────────────╯
-- NOTE: This plugin works with other commenting plugins like vim-commentary; it
-- does all the integrating automagically, but just noting here in case.
local Plugin = { "JoosepAlviste/nvim-ts-context-commentstring" }

Plugin.enabled = false

Plugin.treesitter_config = {
  enable = true,
  config = {
    rust = {
      __default = "// %s",
      comment = "// %s",
    },
  },
}

return Plugin
