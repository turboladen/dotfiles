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
  keys = {
    { "<leader>tn", "<cmd>TestNearest<CR>", desc = "Run nearest test" },
    { "<leader>tf", "<cmd>TestFile<CR>",    desc = "Run all tests in file" },
    { "<leader>ta", "<cmd>TestSuite<CR>",   desc = "Run all tests in project" },
    { "<leader>tl", "<cmd>TestLast<CR>",    desc = "Re-run the last test command" },
    { "<leader>tg", "<cmd>TestVisit<CR>",   desc = "Visit the last test file" }
  }
}
