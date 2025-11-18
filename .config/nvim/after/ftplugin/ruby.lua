-- Ruby-specific settings and keymaps
-- This file is sourced after LSP initializes for Ruby files

local bufnr = vim.api.nvim_get_current_buf()

-- Ruby-specific buffer settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- Folding is now handled by vim-ruby plugin for better Ruby-aware folding

-- Highlight debugging statements as errors to make them obvious
vim.cmd([[
  augroup highlight_ruby_debug
    autocmd! * <buffer>
    autocmd BufEnter <buffer> syn match error contained "\<binding\.pry\>"
    autocmd BufEnter <buffer> syn match error contained "\<debugger\>"
    autocmd BufEnter <buffer> syn match error contained "\<byebug\>"
  augroup END
]])

-- Ruby-specific LSP keymaps
local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "Ruby: " .. desc })
end

-- Rails-specific navigation (when vim-rails is available)
if vim.fn.exists(":Rails") > 0 then
  map("<leader>rm", "<cmd>Emodel<cr>", "Go to [M]odel")
  map("<leader>rv", "<cmd>Eview<cr>", "Go to [V]iew")
  map("<leader>rc", "<cmd>Econtroller<cr>", "Go to [C]ontroller")
  map("<leader>rh", "<cmd>Ehelper<cr>", "Go to [H]elper")
  map("<leader>rs", "<cmd>Espec<cr>", "Go to [S]pec/Test")
  map("<leader>rf", "<cmd>Efixture<cr>", "Go to [F]ixture")
  map("<leader>rg", "<cmd>Emigration<cr>", "Go to Mi[g]ration")
  map("<leader>rl", "<cmd>Elocale<cr>", "Go to [L]ocale")
  map("<leader>ri", "<cmd>Einitializer<cr>", "Go to [I]nitializer")
  map("<leader>rr", "<cmd>R<cr>", "[R]elated File")
  map("<leader>ra", "<cmd>A<cr>", "[A]lternate File")
end

-- Rake support keymaps
if vim.fn.exists(":Rake") > 0 then
  map("<leader>rk", "<cmd>Rake<cr>", "Run Ra[k]e")
end

-- Debug helper: insert caller trace with visual separators
map("<leader>x", function()
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local debug_lines = {
    'puts "#" * 90',
    "puts caller",
    'puts "#" * 90',
  }
  vim.api.nvim_buf_set_lines(bufnr, line, line, false, debug_lines)
  vim.api.nvim_win_set_cursor(0, { line + #debug_lines, 0 })
end, "Insert caller trace")

-- Ruby-specific text objects and motions
-- These work with the built-in Ruby support in Neovim

-- Set up Ruby-specific abbreviations if desired
-- vim.cmd([[iabbrev <buffer> pry require 'pry'; binding.pry]])
-- vim.cmd([[iabbrev <buffer> byebug require 'byebug'; byebug]])
