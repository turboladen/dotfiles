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

  -- ╭────────────────────────────────────╮
  -- │ It sets vim.ui.select to telescope │
  -- ╰────────────────────────────────────╯
  'nvim-telescope/telescope-ui-select.nvim',
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

Plugin.config = function(_, opts)
  require("telescope").setup {
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        }

        -- pseudo code / specification for writing custom displays, like the one
        -- for "codeactions"
        -- specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        --   codeactions = false,
        -- }
      }
    }
  }
  -- To get ui-select loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require("telescope").load_extension("ui-select")
end

return Plugin
