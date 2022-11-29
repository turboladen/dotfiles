-- Setup telescope-alternate
local telescope = require("telescope")

telescope.load_extension("telescope-alternate")
telescope.load_extension("aerial")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
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
})

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

vim.keymap.set(
  "n",
  "<leader>fn",
  nvim_config_files,
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<leader>fy",
  yadm_files,
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<leader>fa",
  ":Telescope telescope-alternate alternate_file<CR>",
  { noremap = true, silent = true }
)

vim.keymap.set(
  "n",
  "<leader>sa",
  "<cmd>Telescope aerial<CR>",
  { noremap = true, silent = true }
)

return {
  nvim_config_files = nvim_config_files,
  yadm_files = yadm_files,
}
