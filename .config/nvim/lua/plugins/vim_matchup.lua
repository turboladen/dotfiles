-- ╭───────────────────────────────────────────────────────────────────────╮
-- │ match-up is a plugin that lets you highlight, navigate, and operate   │
-- │ on sets of matching text. It extends vim's % key to language-specific │
-- │ words instead of just single characters.                              │
-- ╰───────────────────────────────────────────────────────────────────────╯
local Plugin = { "andymass/vim-matchup" }

Plugin.event = "VeryLazy"

Plugin.init = function()
  vim.g.matchup_surround_enabled = 1
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

Plugin.treesitter_config = {
  enable = true,
  -- disable = { "rust" },
}

return Plugin
