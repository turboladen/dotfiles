-- ╭────────────────────────────────╮
-- │ A better annotation generator. │
-- ╰────────────────────────────────╯
return {
  "danymat/neogen",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function(_, opts)
    local neogen = require("neogen")
    neogen.setup(opts)

    local map_opts = { noremap = true, silent = true }

    vim.keymap.set("n", "<leader>ng", neogen.generate, map_opts)

    vim.keymap.set("i", "<C-l>", neogen.jump_next, map_opts)
    vim.keymap.set("i", "<C-h>", neogen.jump_prev, map_opts)
  end
}
