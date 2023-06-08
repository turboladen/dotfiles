-- ╭─────────────────────────────────────────────────────────╮
-- │ Icon set using nonicons for neovim plugins and settings │
-- ╰─────────────────────────────────────────────────────────╯
return {
  "yamatsum/nvim-nonicons",
  priority = 950,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    require('nvim-nonicons').setup(opts)
  end
}
