return {
  "rcarriga/nvim-notify",
  priority = 900,
  dependencies = {
    "yamatsum/nvim-nonicons",
    "nvim-telescope/telescope.nvim",
  },
  init = function()
    vim.opt.termguicolors = true
  end,
  opts = {
    icons = require("nvim-nonicons.extentions.nvim-notify").icons
  },
  config = function(_, opts)
    vim.notify = require("notify")
    require("notify").setup(opts)

    local telescope = require("telescope")
    telescope.load_extension("notify")
  end
}
