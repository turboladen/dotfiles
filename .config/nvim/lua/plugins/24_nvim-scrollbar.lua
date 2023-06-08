-- ╭─────────────────────────────╮
-- │ Extensible Neovim Scrollbar │
-- ╰─────────────────────────────╯
return {
  "petertriho/nvim-scrollbar",
  config = function()
    require("scrollbar").setup({})
  end
}
