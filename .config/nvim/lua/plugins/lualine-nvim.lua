-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ A blazing fast and easy to configure neovim statusline plugin written        │
-- │  in pure lua.                                                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
require('lualine').setup {
  options = {
    component_separators = "󰇙",
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      { 'branch' },
      -- { 'diff', separator = { right = "" }, color = { bg = "#000000" } },
      { 'diff', separator = { right = "" } },
      { 'filename', path = 1, separator = { right = "" } },
    },
    lualine_c = { 'tabs' },
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_lsp', 'nvim_diagnostic' }
      }
    },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {
      { 'filename', path = 1 },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = { "aerial", "fugitive", "mason", "quickfix", "trouble" },
}
