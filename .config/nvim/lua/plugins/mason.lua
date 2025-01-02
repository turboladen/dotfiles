-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │  Portable package manager for Neovim that runs everywhere Neovim         │
-- │  runs.                                                                   │
-- ╰──────────────────────────────────────────────────────────────────────────╯
require("mason").setup()

require("mason-lspconfig").setup({
  automatic_installation = false,
})
