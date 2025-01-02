-- ╭─────────────────────────────────────────╮
-- │ Neovim plugin for a code outline window │
-- ╰─────────────────────────────────────────╯
local aerial = require("aerial")

aerial.setup({
  filter_kind = false,
  on_attach = function(bufnr)
    require("which-key").add({
      { "<leader>ba", aerial.toggle,   desc = "aerial: Toggle symbols",     buffer = bufnr },
      { "<leader>bn", "<CMD>AerialNavToggle<CR>", desc = "aerial: Toggle nav symbols", buffer = bufnr },

      -- Jump forwards/backwards with '{' and '}'
      { "{",          aerial.prev,     desc = "aerial: Previous",           buffer = bufnr },
      { "}",          aerial.next,     desc = "aerial: Next",               buffer = bufnr },

      -- Jump up the tree with '[[' or ']]'
      { "[[",         aerial.prev_up,  desc = "aerial: Previous up",        buffer = bufnr },
      { "]]",         aerial.next_up,  desc = "aerial: Next up",            buffer = bufnr },
    })
  end
})

local telescope = require("telescope")
telescope.load_extension('aerial')
