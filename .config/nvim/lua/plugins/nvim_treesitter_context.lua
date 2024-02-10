-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Lightweight alternative to context.vim implemented with nvim-treesitter. │
-- ╰──────────────────────────────────────────────────────────────────────────╯
local Plugin = { "nvim-treesitter/nvim-treesitter-context" }

Plugin.opts = {
  max_lines = 2,
}

return Plugin
