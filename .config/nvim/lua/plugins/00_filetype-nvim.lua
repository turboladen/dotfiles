-- ╭──────────────────────────────────────────────────────────────────────╮
-- │  This plugin is a replacement for the included filetype.vim that is  │
-- │  sourced on startup.                                                 │
-- ╰──────────────────────────────────────────────────────────────────────╯

return {
  "nathom/filetype.nvim",
  priority = 999,
  opts = {
    overrides = {
      extensions = {
        -- Set the filetype of *.pn files to potion
        jbuilder = "ruby"
      },
      complex = {
        ["*.rs.hbs"] = "rust.handlebars", -- Included in the plugin
      },
    },
  },
  config = function(_, opts)
    require("filetype").setup(opts)
  end
}
