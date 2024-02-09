-- ╭────────────────────────────────╮
-- │ A better annotation generator. │
-- ╰────────────────────────────────╯
local Plugin = { "danymat/neogen" }

Plugin.event = "VeryLazy"
Plugin.dependencies = { "nvim-treesitter/nvim-treesitter" }

Plugin.opts = {
  snippet_engine = "snippy"
}

Plugin.config = function(_, opts)
  local neogen = require("neogen")
  neogen.setup(opts)
end

return Plugin
