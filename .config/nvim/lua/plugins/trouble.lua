-- ╭──────────────────────────────────────────────────────────────────────╮
-- │ 🚦 A pretty diagnostics, references, telescope results, quickfix and │
-- │ location list to help you solve all the trouble your code is causing.│
-- ╰──────────────────────────────────────────────────────────────────────╯
local Plugin = { "folke/trouble.nvim" }

Plugin.dependencies = { "nvim-tree/nvim-web-devicons" }
Plugin.cmd = { "Trouble", "TroubleRefresh", "TroubleToggle" }

Plugin.opts = {
  -- auto_preview = false,
  auto_close = true,
  use_diagnostic_signs = true
}
Plugin.config = function(_, opts)
  require("trouble").setup(opts)
end

return Plugin
