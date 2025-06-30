-- General keymaps that don't belong to specific plugins
-- These are mostly built-in vim/neovim functionality

local map = vim.keymap.set

-- Better paste behavior - move cursor to end of pasted text
map("n", "p", "p`]", { desc = "Edit: Paste, move to end" })
map("v", "y", "y`]", { desc = "Edit: Yank, move to end" })

-- Split line and remove trailing whitespace
map("n", "S", "i<cr><esc>mwgk:silent! s/\\v +$//<cr>:noh<cr>", { desc = "Edit: Split line, clean" })

-- Terminal escape
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Term: Exit mode" })

-- Window navigation
map("n", "<c-h>", "<c-w>h", { desc = "Win: Left" })
map("n", "<c-j>", "<c-w>j", { desc = "Win: Down" })
map("n", "<c-k>", "<c-w>k", { desc = "Win: Up" })
map("n", "<c-l>", "<c-w>l", { desc = "Win: Right" })

-- Search highlighting control
map("n", "<leader>sl", "<cmd>noh<cr>", { desc = "Search: Clear highlight" })

-- Open URL/file under cursor
map("n", "gx", function()
  local word = vim.fn.expand("<cfile>")
  if word:match("^https?://") then
    vim.fn.system({ "open", word })
  else
    vim.cmd("normal! gF")
  end
end, { desc = "Open: Item under cursor" })

-- Package management
map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Pkg: Lazy update" })
map("n", "<leader>pm", "<cmd>Mason<cr>", { desc = "Pkg: Mason" })
