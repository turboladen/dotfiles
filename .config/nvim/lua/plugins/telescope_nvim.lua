-- ╭─────────────────────────────────────────────────────╮
-- │ Find, Filter, Preview, Pick. All lua, all the time. │
-- ╰─────────────────────────────────────────────────────╯

local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.branch = "0.1.x"
Plugin.event = "VeryLazy"

Plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope-symbols.nvim",
  require("plugins.nvim_treesitter"),
  require("plugins.telescope_fzf_native_nvim"),
  require("plugins.nvim_nonicons"),
  require("plugins.telescope_ui_select_nvim"),
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
    extensions = {
      ["ui-select"] = require("plugins.telescope_ui_select_nvim").extension_config(),
      fzf = require("plugins.telescope_fzf_native_nvim").extension_config(),
    },
  }
end

Plugin.config = function(_, opts)
  require("telescope").setup(opts)

  -- To get ui-select loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require("telescope").load_extension("ui-select")
  require('telescope').load_extension('fzf')
end

return Plugin
