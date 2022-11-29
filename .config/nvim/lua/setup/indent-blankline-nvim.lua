vim.opt.list = true

require("indent_blankline").setup(
  {
    char = "┊",
    char_highlight = "LineNr",
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = { "rust", "lua", "ruby" },
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  }
)
