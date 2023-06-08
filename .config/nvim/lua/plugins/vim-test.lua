return {
  "vim-test/vim-test",
  dependencies = {
    "tpope/vim-dispatch",
    "voldikss/vim-floaterm",
  },
  init = function()
    vim.g.floaterm_wintype = "split"
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_autoinsert = false
    vim.g.floaterm_height = 0.3

    vim.g["test#strategy"] = {
      nearest = "floaterm",
      last = "floaterm",
      file = "dispatch",
      suite = "dispatch"
    }
    vim.g["test#preserve_screen"] = 1
    vim.g["test#enabled_runners"] = {
      "ruby#rspec",
      "ruby#rails",
      "rust#cargotest"
    }
  end,
  opts = {},
  config = function()
    vim.keymap.set("n", "<space>xn", "<cmd>TestNearest<CR>")
    vim.keymap.set("n", "<space>xf", "<cmd>TestFile<CR>")
    vim.keymap.set("n", "<space>xa", "<cmd>TestSuite<CR>")
    vim.keymap.set("n", "<space>xl", "<cmd>TestLast<CR>")
    vim.keymap.set("n", "<space>xg", "<cmd>TestVisit<CR>")
  end,
}
