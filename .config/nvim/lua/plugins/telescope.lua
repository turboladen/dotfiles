-- ╭─────────────────────────────────────────────────────╮
-- │ Find, Filter, Preview, Pick. All lua, all the time. │
-- ╰─────────────────────────────────────────────────────╯

local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.branch = "0.1.x"
Plugin.event = "VeryLazy"

Plugin.dependencies = {
  "yamatsum/nvim-nonicons",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-telescope/telescope-symbols.nvim",
  "nvim-treesitter/nvim-treesitter",
}

Plugin.opts = function()
  local icons = require("nvim-nonicons")

  return {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = require("telescope.actions").close,
          ["<C-h>"] = "which_key"
        },
      },
      prompt_prefix = "  " .. icons.get("telescope") .. "  ",
      selection_caret = " ❯ ",
      entry_prefix = "   ",
    },
    pickers = {
      buffers = {
        theme = "cursor",
        previewer = false,
      },
      find_files = {
        theme = "dropdown",
        previewer = false,
      },
      lsp_code_actions = {
        theme = "cursor",
        layout_config = { height = 15 },
      },
      oldfiles = {
        theme = "dropdown",
      },
    },
  }
end

return Plugin
