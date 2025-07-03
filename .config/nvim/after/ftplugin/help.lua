-- Help file specific settings and keymaps

-- Map 'q' to quit help windows
vim.keymap.set("n", "q", "<cmd>quit<cr>", {
  buffer = true,
  desc = "Quit help window",
})
