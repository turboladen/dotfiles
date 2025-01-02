-- ╭───────────────────────────────────────────────────────────────────────╮
-- │ match-up is a plugin that lets you highlight, navigate, and operate   │
-- │ on sets of matching text. It extends vim's % key to language-specific │
-- │ words instead of just single characters.                              │
-- ╰───────────────────────────────────────────────────────────────────────╯
vim.g.matchup_surround_enabled = 1
vim.g.matchup_matchparen_offscreen = { method = "popup" }

require("nvim-treesitter.configs").setup({
  matchup = {
    enable = true,
  }
})
