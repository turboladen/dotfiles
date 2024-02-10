-- ╭───────────────────────────╮
-- │ Hyperfocus-writing in Vim │
-- ╰───────────────────────────╯
local Plugin = { "junegunn/limelight.vim" }

Plugin.cmd = "Limelight"
Plugin.init = function()
  vim.g.limelight_paragraph_span = 1
end

return Plugin
