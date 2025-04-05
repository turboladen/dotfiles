-- ╭─────────────────────────────────────────────────────────╮
-- │ Icon set using nonicons for neovim plugins and settings │
-- ╰─────────────────────────────────────────────────────────╯
require("nvim-nonicons").setup({})

-- ╭────────╮
-- │ fidget │
-- ╰────────╯
require("fidget").setup({})

-- ╭──────────╮
-- │ gitsigns │
-- ╰──────────╯
require("gitsigns").setup({
  signs = {
    changedelete = { text = "⇄" },
  },
  on_attach = function(bufnr)
    require("user.keymaps").gitsigns(bufnr)
  end,
})
