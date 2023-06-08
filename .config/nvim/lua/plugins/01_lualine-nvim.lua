-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ A blazing fast and easy to configure neovim statusline plugin written        │
-- │  in pure lua.                                                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

-- ╭───────────────────────────────────────────────────────────────────────────────────────────╮
-- │ Bubbles config for lualine                                                                │
-- │ Author: lokesh-krishna                                                                    │
-- │ MIT license, see LICENSE for more details.                                                │
-- │ https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua#enroll-beta │
-- ╰───────────────────────────────────────────────────────────────────────────────────────────╯

local function modified()
  if vim.bo.modified then
    return '+'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '-'
  end
  return ''
end

-- bubbly.nvim colors
local colors = {
  blue = "#6cb6eb",
  cyan = "#5dbbc1",
  black = "#3e4249",
  black2 = "#111111",
  white = "#c5cdd9",
  red = "#ec7279",
  violet = "#d38aea",
  lightgrey = "#57595e",
  darkgrey = "#404247",
  darkorange = "#844212"
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.lightgrey },
    c = { fg = colors.black, bg = colors.darkgrey },
  },
  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },
  inactive = {
    a = { fg = colors.white, bg = colors.darkgrey },
    b = { fg = colors.white, bg = colors.darkgrey },
    c = { fg = colors.black, bg = colors.darkgrey },
  },
}


-- local empty = require('lualine.component'):extend()

-- function empty:draw(default_highlight)
--   self.status = ''
--   self.applied_separator = ''
--   self:apply_highlights(default_highlight)
--   self:apply_section_separators()
--   return self.status
-- end

-- Put proper separators and gaps between components in sections
-- local function process_sections(sections)
--   for name, section in pairs(sections) do
--     local left = name:sub(9, 10) < 'x'
--     for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
--       table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
--     end
--     for id, comp in ipairs(section) do
--       if type(comp) ~= 'table' then
--         comp = { comp }
--         section[id] = comp
--       end
--       comp.separator = left and { right = '' } or { left = '' }
--     end
--   end
--   return sections
-- end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'stevearc/aerial.nvim',
  },
  opts = {
    options = {
      theme = bubbles_theme,
      component_separators = "",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          separator = { left = '' },
          right_padding = 2,
        },
      },
      lualine_b = {
        { 'branch', color = { bg = colors.darkorange } },
        {
          'diff',
          separator = { right = "" },
          color = { bg = "#000000" },
        },
        {
          'filename',
          path = 1,
          separator = { right = "" },
        },
        { modified, color = { bg = colors.red } },
      },
      -- lualine_c = { 'fileformat' },
      lualine_c = {
        'tabs'
      },
      -- lualine_x = { 'diagnostics' },
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
      },
      lualine_y = { 'filetype', 'progress' },
      lualine_z = {
        { 'location', separator = { right = '' }, left_padding = 2 },
      },
    },
    inactive_sections = {
      lualine_a = {
        { 'filename', path = 1 },
        { modified,   color = { bg = colors.red } },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = { 'location' },
    },
    tabline = {},
    extensions = { "aerial", "quickfix", "trouble" },
  }
}
