-- ╭──────────────────────────────────╮
-- │ Distraction-free writing in Vim. │
-- ╰──────────────────────────────────╯
local Plugin = { "junegunn/goyo.vim" }

Plugin.cmd = "Goyo"
Plugin.init = function()
  vim.g.goyo_width = 102
end

return Plugin
