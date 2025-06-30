-- General keymaps that don't belong to specific plugins
-- These are mostly built-in vim/neovim functionality

local map = vim.keymap.set

-- Better paste behavior - move cursor to end of pasted text
map("n", "p", "p`]", { desc = "Paste, then move to end of text" })
map("v", "y", "y`]", { desc = "Yank, then move to end of text" })

-- Split line and remove trailing whitespace
map(
  "n",
  "S",
  "i<cr><esc>mwgk:silent! s/\\v +$//<cr>:noh<cr>",
  { desc = "Split line, remove whitespace" }
)

-- Terminal escape
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })

-- Window navigation
map("n", "<c-h>", "<c-w>h", { desc = "Move to left pane" })
map("n", "<c-j>", "<c-w>j", { desc = "Move to down pane" })
map("n", "<c-k>", "<c-w>k", { desc = "Move to up pane" })
map("n", "<c-l>", "<c-w>l", { desc = "Move to right pane" })

-- Search highlighting control
map("n", "<leader>sl", "<cmd>noh<cr>", { desc = "Stop highlighting hlsearch" })

-- Open URL/file under cursor
map("n", "gx", function()
  local word = vim.fn.expand("<cfile>")
  if word:match("^https?://") then
    vim.fn.system({ "open", word })
  else
    vim.cmd("normal! gF")
  end
end, { desc = "Open item under cursor" })

-- Package management
map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Lazy update" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Mason" })
