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

-- Ripgrep to quickfix
map("n", "<leader>.", ":Rg ", { desc = "Rg: Search to quickfix" })

-- :Rg <pattern> [path ...] — ripgrep straight to quickfix (no picker)
vim.api.nvim_create_user_command("Rg", function(opts)
  local args = opts.fargs
  if #args == 0 then
    vim.notify("Usage: :Rg <pattern> [path ...]", vim.log.levels.WARN)
    return
  end

  local cmd = { "rg", "--vimgrep", "--smart-case", unpack(args) }

  vim.fn.setqflist({}, " ", {
    title = ":Rg " .. table.concat(args, " "),
    lines = vim.fn.systemlist(cmd),
    efm = "%f:%l:%c:%m",
  })
  vim.cmd("copen")
end, {
  nargs = "+",
  complete = "file",
  desc = "Ripgrep to quickfix",
})

-- Package management
map("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "Pkg: Lazy update" })
