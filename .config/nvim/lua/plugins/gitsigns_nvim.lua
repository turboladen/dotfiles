--  ╭─────────────────────────────╮
--  │ Git integration for buffers │
--  ╰─────────────────────────────╯
local Plugin = { "lewis6991/gitsigns.nvim" }

Plugin.dependencies = { "nvim-lua/plenary.nvim" }
Plugin.event = { "BufReadPre", "BufNewFile" }

Plugin.opts = {
  signs = {
    changedelete = { text = "⇄" },
  },
  yadm = { enable = true },
  on_attach = function(bufnr)
    require("user.keymaps").gitsigns(bufnr)
  end,
}

return Plugin
