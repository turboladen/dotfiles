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
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Aerial does not set any mappings by default, so you'll want to set some up
    -- Toggle the aerial window with <leader>a
    vim.keymap.set("n", "<leader>aa", require("aerial").toggle, opts)

    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", require("aerial").prev, opts)
    vim.keymap.set("n", "}", require("aerial").next, opts)

    -- Jump up the tree with '[[' or ']]'
    vim.keymap.set("n", "[[", require('aerial').prev_up, opts)
    vim.keymap.set("n", "]]", require('aerial').next_up, opts)
  end
}

Plugin.config = function(_, opts)
  local telescope = require("telescope")
  require("aerial").setup(opts)
  telescope.load_extension('aerial')
end

return Plugin
