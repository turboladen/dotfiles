-- Markdown-specific settings and keymaps
-- This file is sourced after LSP initializes for Markdown files

local bufnr = vim.api.nvim_get_current_buf()

-- Markdown-specific buffer settings
vim.bo.textwidth = 100
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.spell = true
vim.wo.conceallevel = 2 -- Enable concealing for better readability

-- Markdown-specific LSP keymaps
local map = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { silent = true, buffer = bufnr, desc = "Markdown: " .. desc })
end

-- Peek preview keymaps (when peek.nvim is available)
if pcall(require, "peek") then
  map("<leader>mp", "<cmd>PeekOpen<cr>", "Open [P]review")
  map("<leader>mc", "<cmd>PeekClose<cr>", "[C]lose Preview")
  map("<leader>mt", "<cmd>PeekToggle<cr>", "[T]oggle Preview")
end

-- Markdown navigation and editing
map("<leader>ml", function()
  -- Insert markdown link
  local word = vim.fn.expand("<cword>")
  local link = string.format("[%s]()", word)
  vim.api.nvim_put({ link }, "c", true, true)
  -- Position cursor inside parentheses
  vim.api.nvim_feedkeys("F)i", "n", false)
end, "Insert [L]ink")

map("<leader>mi", function()
  -- Insert markdown image
  local word = vim.fn.expand("<cword>")
  local image = string.format("![%s]()", word)
  vim.api.nvim_put({ image }, "c", true, true)
  -- Position cursor inside parentheses
  vim.api.nvim_feedkeys("F)i", "n", false)
end, "Insert [I]mage")

map("<leader>mb", function()
  -- Toggle bold formatting
  local word = vim.fn.expand("<cword>")
  local bold = string.format("**%s**", word)
  vim.cmd("normal! ciw" .. bold)
end, "Toggle [B]old")

map("<leader>me", function()
  -- Toggle italic formatting
  local word = vim.fn.expand("<cword>")
  local italic = string.format("*%s*", word)
  vim.cmd("normal! ciw" .. italic)
end, "Toggle Italic ([E]mphasis)")

map("<leader>mh", function()
  -- Insert heading
  local line = vim.api.nvim_get_current_line()
  local new_line = "# " .. line
  vim.api.nvim_set_current_line(new_line)
end, "Add [H]eading")

-- Table formatting helpers
map("<leader>mtf", function()
  -- Format markdown table (requires external tool like 'pandoc' or manual implementation)
  vim.cmd("normal! vip:!pandoc -f markdown -t markdown")
end, "[T]able [F]ormat")

-- Code block insertion
map("<leader>mcc", function()
  -- Insert code block
  local lines = { "```", "", "```" }
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
  vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
end, "Insert [C]ode Block")

map("<leader>mci", function()
  -- Insert inline code
  local word = vim.fn.expand("<cword>")
  local code = string.format("`%s`", word)
  vim.cmd("normal! ciw" .. code)
end, "Inline [C]ode")

-- Task list helpers
map("<leader>mx", function()
  -- Toggle checkbox
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line:match("^%s*%- %[ %]") then
    new_line = line:gsub("^(%s*%- )%[ %]", "%1[x]")
  elseif line:match("^%s*%- %[x%]") then
    new_line = line:gsub("^(%s*%- )%[x%]", "%1[ ]")
  else
    new_line = line:gsub("^(%s*%- )", "%1[ ] ")
  end
  vim.api.nvim_set_current_line(new_line)
end, "Toggle Checkbo[x]")

-- Folding for markdown sections (if not using treesitter folding)
vim.wo.foldmethod = "expr"
vim.wo.foldexpr =
  "v:lnum==1?'>1':getline(v:lnum)=~'^#'?'>'.len(matchstr(getline(v:lnum),'^#\\+')):'='"
