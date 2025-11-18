-- Git commit message specific settings
-- This file is sourced after LSP initializes for git commit files

local bufnr = vim.api.nvim_get_current_buf()

-- Git commit specific buffer settings
vim.bo.textwidth = 72
vim.bo.colorcolumn = "50,72"
vim.wo.spell = true
vim.wo.wrap = true
vim.wo.linebreak = true

-- Better commit editing experience
-- Start in insert mode if the commit message is empty
if vim.fn.getline(1) == "" then
  vim.cmd("startinsert")
end

-- Create a simple diff view helper
local function show_diff()
  -- Open a horizontal split below with git diff
  vim.cmd("belowright split")
  local diff_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, diff_bufnr)
  vim.bo[diff_bufnr].filetype = "diff"
  vim.bo[diff_bufnr].buftype = "nofile"
  vim.bo[diff_bufnr].swapfile = false

  -- Get git diff and populate buffer
  local diff_output = vim.fn.system("git diff --cached")
  if vim.v.shell_error == 0 and diff_output ~= "" then
    local lines = vim.split(diff_output, "\n")
    vim.api.nvim_buf_set_lines(diff_bufnr, 0, -1, false, lines)
  else
    vim.api.nvim_buf_set_lines(diff_bufnr, 0, -1, false, { "No staged changes to show" })
  end

  -- Make it read-only and return to commit message window
  vim.bo[diff_bufnr].readonly = true
  vim.cmd("wincmd p")
end

-- Create a status view helper
local function show_status()
  -- Open a vertical split on the right with git status
  vim.cmd("belowright vsplit")
  local status_bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(0, status_bufnr)
  vim.bo[status_bufnr].filetype = "git"
  vim.bo[status_bufnr].buftype = "nofile"
  vim.bo[status_bufnr].swapfile = false

  -- Get git status and populate buffer
  local status_output = vim.fn.system("git status --porcelain")
  if vim.v.shell_error == 0 then
    local lines = vim.split(status_output, "\n")
    vim.api.nvim_buf_set_lines(status_bufnr, 0, -1, false, lines)
  else
    vim.api.nvim_buf_set_lines(status_bufnr, 0, -1, false, { "No git repository" })
  end

  -- Make it read-only and return to commit message window
  vim.bo[status_bufnr].readonly = true
  vim.cmd("wincmd p")
end

-- Git commit specific keymaps
local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "Git: " .. desc })
end

-- Quick commit type prefixes
map("<leader>gf", function()
  vim.api.nvim_put({ "feat: " }, "c", false, true)
  vim.cmd("startinsert!")
end, "[F]eat prefix")

map("<leader>gb", function()
  vim.api.nvim_put({ "fix: " }, "c", false, true)
  vim.cmd("startinsert!")
end, "Fix ([B]ug) prefix")

map("<leader>gdo", function()
  vim.api.nvim_put({ "docs: " }, "c", false, true)
  vim.cmd("startinsert!")
end, "[Do]cs prefix")

map("<leader>gr", function()
  vim.api.nvim_put({ "refactor: " }, "c", false, true)
  vim.cmd("startinsert!")
end, "[R]efactor prefix")

map("<leader>gt", function()
  vim.api.nvim_put({ "test: " }, "c", false, true)
  vim.cmd("startinsert!")
end, "[T]est prefix")

map("<leader>gc", function()
  vim.api.nvim_put({ "chore: " }, "c", false, true)
  vim.cmd("startinsert!")
end, "[C]hore prefix")

-- View helpers - show diff and status
map("<leader>gd", show_diff, "Show [D]iff")
map("<leader>gst", show_status, "Show [St]atus")

-- Template helpers
-- Set cursor to start of first line if empty
vim.api.nvim_create_autocmd("BufEnter", {
  buffer = bufnr,
  callback = function()
    if vim.fn.getline(1) == "" then
      vim.api.nvim_win_set_cursor(0, { 1, 0 })
    end
  end,
})
