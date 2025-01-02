
require("gruvbox").setup({
  dim_inactive = true
})

require("everforest").setup({
  -- background = "hard",
  italics = true,
  ui_contrast = "high",
  dim_inactive_windows = true,
  diagnostic_line_highlight = true,
  spell_foreground = true,
  -- inlay_hints_background = "dimmed"
})

require('kanagawa').setup({
  compile = true,
  dimInactive = true
})

require("modus-themes").setup({
  dim_inactive = true
})

require('nightfox').setup({
  options = {
    dim_inactive = true,
    colorblind = {
      enable = true
    },
    styles = {
      comments = "italic",
      keywords = "italic",
      types = "italic,bold",
    }
  },
})

vim.g.sonokai_style = "shusia"
-- vim.g.sonokai_style = "espresso"
vim.g.sonokai_better_performance = 1
vim.g.sonokai_dim_inactive_windows = 1

require("tokyonight").setup({
  dim_inactive = true,
  lualine_bold = true
})


require("bamboo").setup({
  dim_inactive = true,
  ending_tildes = true,
  lualine = {
    transparent = true
  },
  diagnostics = {
    darker = true
  }
})
