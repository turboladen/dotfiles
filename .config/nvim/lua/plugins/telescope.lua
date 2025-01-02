-- ╭─────────────────────────────────────────────────────╮
-- │ Find, Filter, Preview, Pick. All lua, all the time. │
-- ╰─────────────────────────────────────────────────────╯
local icons = require("nvim-nonicons")

require("telescope").setup({
  {
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
      },
      fzf = {
        -- fuzzy = true,                   -- false will only do exact matching
        -- override_generic_sorter = true, -- override the generic sorter
        -- override_file_sorter = true,    -- override the file sorter
        -- case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        case_mode = "respect_case", -- or "ignore_case" or "respect_case"
      },
    },
  }
})

require("telescope").load_extension("ui-select")
-- require('telescope').load_extension('fzf')

local M = {}

-- Setup nvim config file finder
M.nvim_config_files = function()
  require("telescope.builtin").find_files({
    cwd = "~/.config/nvim",
    prompt_title = "Find neovim config files"
  })
end

-- Function for defining a telescope picker over all the files that I manage using yadm.io.
M.yadm_files = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local opts = {
    theme = "dropdown",
    previewer = false,
    layout_config = {
      height = 20,
      width = 80,
    },
  }
  local files_string = vim.fn.system("yadm list -a") or ""
  local files = vim.split(files_string, "\n")

  pickers.new(opts, {
    prompt_title = "YADM Config Files",
    finder = finders.new_table({
      results = files,
      entry_maker = function(entry)
        -- meow
        return {
          value = "~/" .. entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    previewer = conf.file_previewer(opts),
    sorter = conf.file_sorter(opts),
  }):find()
end

return M
