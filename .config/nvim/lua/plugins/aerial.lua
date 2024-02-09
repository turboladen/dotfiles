-- ╭─────────────────────────────────────────╮
-- │ Neovim plugin for a code outline window │
-- ╰─────────────────────────────────────────╯
local Plugin = { "stevearc/aerial.nvim" }

Plugin.dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-web-devicons",
  "nvim-telescope/telescope.nvim",
}

-- Plugin.enabled = false

Plugin.lazy = true

Plugin.opts = {
  filter_kind = false,
  on_attach = function(bufnr)
    require("user.keymaps").aerial(bufnr)
  end
}

Plugin.config = function(_, opts)
  local telescope = require("telescope")
  require("aerial").setup(opts)
  telescope.load_extension('aerial')
end

return Plugin
