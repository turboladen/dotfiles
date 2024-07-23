-- ╭─────────────────────────────────────────╮
-- │ Neovim plugin for a code outline window │
-- ╰─────────────────────────────────────────╯
local Plugin = { "stevearc/aerial.nvim" }

Plugin.dependencies = {
  require("plugins.nvim_treesitter"),
  require("plugins.nvim_web_devicons"),
  require("plugins.telescope_nvim"),
}

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
