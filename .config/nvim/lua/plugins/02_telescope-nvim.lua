-- ╭─────────────────────────────────────────────────────╮
-- │ Find, Filter, Preview, Pick. All lua, all the time. │
-- ╰─────────────────────────────────────────────────────╯
local icons = require("nvim-nonicons")

local telescope_opts = {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
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

-- Setup nvim config file finder
local nvim_config_files = function()
  require("telescope.builtin").find_files({
    cwd = "~/.config/nvim",
    prompt_title = "Find neovim config files"
  })
end

-- Function for defining a telescope picker over all the files that I manage using yadm.io.
local yadm_files = function()
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
  local files_string = vim.fn.system("yadm list -a")
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


return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-treesitter/nvim-treesitter",
    "yamatsum/nvim-nonicons",

  },
  opts = telescope_opts,
  keys = {
    { "<leader>fn", nvim_config_files,                                       { desc = "Show files in ~/.config/nvim/" } },
    { "<leader>fy", yadm_files,                                              { desc = "Show YADM files" } },
    { "<leader>fa", "<cmd>Telescope telescope-alternate alternate_file<CR>", { desc = "Show alternate file" } },
    { "<leader>fs", "<cmd>Telescope aerial<CR>",                             { desc = "Show symbols via aerial" } },
  }
}
