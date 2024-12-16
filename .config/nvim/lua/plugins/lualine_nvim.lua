-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ A blazing fast and easy to configure neovim statusline plugin written        │
-- │  in pure lua.                                                                │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
local Plugin        = { 'nvim-lualine/lualine.nvim' }

Plugin.event        = "VeryLazy"

Plugin.dependencies = {
  require("plugins.nvim_web_devicons"),
  require("plugins.aerial_nvim"),
}

Plugin.opts         = function()
  return {
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
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          -- color = { fg = "#ff9e64" },
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
    extensions = { "aerial", "fugitive", "lazy", "mason", "quickfix", "trouble" },
  }
end

return Plugin
