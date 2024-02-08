-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ A blazing fast and easy to configure neovim statusline plugin written        │
-- │  in pure lua.                                                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local Plugin        = { 'nvim-lualine/lualine.nvim' }

Plugin.event        = "VeryLazy"

Plugin.dependencies = {
  'nvim-tree/nvim-web-devicons',
  'stevearc/aerial.nvim',
}

Plugin.opts         = function()
  -- ╭───────────────────────────────────────────────────────────────────────────────────────────╮
  -- │ Bubbles config for lualine                                                                │
  -- │ Author: lokesh-krishna                                                                    │
  -- │ MIT license, see LICENSE for more details.                                                │
  -- │ https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua#enroll-beta │
  -- ╰───────────────────────────────────────────────────────────────────────────────────────────╯
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

  return {
    options = {
      theme = bubbles_theme,
      component_separators = "󰇙",
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '' }, right_padding = 2 },
      },
      lualine_b = {
        { 'branch', color = { bg = colors.darkorange } },
        { 'diff', separator = { right = "" }, color = { bg = "#000000" } },
        { 'filename', path = 1, separator = { right = "" } },
      },
      lualine_c = { 'tabs' },
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
end

return Plugin
