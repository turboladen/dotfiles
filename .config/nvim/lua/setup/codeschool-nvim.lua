-- vim.g.codeschool_contrast_dark = "hard"
vim.g.codeschool_italic = 1
-- vim.g.codeschool_sign_column = "none"
-- vim.g.codeschool_color_column = "none"
vim.g.codeschool_invert_signs = 1
vim.g.codeschool_invert_indent_guides = 1
vim.g.codeschool_improved_strings = 1
vim.g.codeschool_improved_warnings = 1
vim.g.codeschool_transparent_bg = 1
vim.g.codeschool_underline = 0
vim.g.codeschool_undercurl = 0

require("lush")(
  require("codeschool").setup(
    {
      plugins = {
        "buftabline",
        "cmp",
        "fzf",
        "gitsigns",
        "lsp",
        "netrw",
        "neogit",
        "packer",
        "telescope",
        "treesitter"
      },
      langs = {
        "c",
        "css",
        "elixir",
        "html",
        "js",
        "json",
        "lua",
        "markdown",
        "objc",
        "python",
        "ruby",
        "rust",
        "scala",
        "typescript",
        "viml",
        "xml"
      }
    }
  )
)
