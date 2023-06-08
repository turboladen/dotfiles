-- ╭────────────────────────────────────────────────────────────────────────╮
-- │ 🦊A highly customizable theme for vim and neovim with support for lsp, │
-- │ treesitter and a variety of plugins.                                   │
-- ╰────────────────────────────────────────────────────────────────────────╯
return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    options = {
      dim_inactive = true,
      inverse = {
        match_paren = true,
        visual = true,
        search = true,
      },
    },
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
  end
}
