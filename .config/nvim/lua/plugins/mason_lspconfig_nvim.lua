-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │  Portable package manager for Neovim that runs everywhere Neovim         │
-- │  runs.                                                                   │
-- ╰──────────────────────────────────────────────────────────────────────────╯
local Plugin = { "williamboman/mason-lspconfig.nvim" }

Plugin.lazy = true

Plugin.dependencies = {
  require("plugins.mason_nvim"),
  -- Requiring this here ends up in a cyclic dependencies
  -- require("plugins.nvim_lspconfig"),
}

Plugin.opts = {
  automatic_installation = false,
}

Plugin.config = function(_, opts)
  require("mason").setup()
  require("mason-lspconfig").setup(opts)
end

return Plugin
