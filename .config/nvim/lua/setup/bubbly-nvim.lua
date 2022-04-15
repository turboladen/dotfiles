require("lsp-status").register_progress()

-- Here you can add the configuration for the plugin
vim.g.bubbly_palette = {
  background = "#34343c",
  foreground = "#c5cdd9",
  black = "#3e4249",
  red = "#ec7279",
  green = "#a0c980",
  yellow = "#deb974",
  blue = "#6cb6eb",
  purple = "#d38aea",
  cyan = "#5dbbc1",
  white = "#c5cdd9",
  lightgrey = "#57595e",
  darkgrey = "#404247"
}

vim.g.bubbly_statusline = {
  "mode",
  "truncate",
  "path",
  "branch",
  -- "gitsigns",
  -- "lsp_status.messages",
  "lsp_status.diagnostics",
  "divisor",
  "filetype",
  "progress"
}
