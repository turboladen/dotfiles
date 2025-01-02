-- Suggestions from https://github.com/mrcjkb/rustaceanvim

local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
  "n",
  "<leader>cc",
  function()
    vim.cmd.RustLsp('openCargo')
  end,
  { silent = true, buffer = bufnr, desc = "Open Cargo.toml" }
)
vim.keymap.set("n", "ff", "<cmd>RustFmt<cr>")
