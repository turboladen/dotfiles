--  ╭─────────────────────────────────────────────────────────────────╮
--  │ Location and syntax aware text objects which *do what you mean* │
--  ╰─────────────────────────────────────────────────────────────────╯
local Plugin = { "RRethy/nvim-treesitter-textsubjects" }

Plugin.lazy = true
Plugin.dependencies = { "nvim-treesitter/nvim-treesitter" }

Plugin.treesitter_config = {
  enable = true,
  prev_selection = ',',
  keymaps = {
    ['.'] = 'textsubjects-smart',
    [';'] = 'textsubjects-container-outer',
    ['i;'] = 'textsubjects-container-inner',
  }
}

return Plugin
