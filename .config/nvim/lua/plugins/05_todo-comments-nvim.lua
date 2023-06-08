-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ Highlight and search for todo comments like TODO, HACK, BUG in your      │
-- │ code base.                                                               │
-- ╰──────────────────────────────────────────────────────────────────────────╯
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    vim.keymap.set("n", "]t", require("todo-comments").jump_next, { desc = "Next todo comment" })
    vim.keymap.set("n", "[t", require("todo-comments").jump_prev, { desc = "Previous todo comment" })
  end
}
