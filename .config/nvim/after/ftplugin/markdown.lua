-- Markdown-specific settings
vim.bo.textwidth = 100
vim.wo.wrap = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.wo.spell = true
vim.wo.conceallevel = 2

-- Peek preview keymaps (actual plugin integration)
if pcall(require, "peek") then
  local bufnr = vim.api.nvim_get_current_buf()
  local map = function(keys, cmd, desc)
    vim.keymap.set("n", keys, cmd, { silent = true, buffer = bufnr, desc = "Markdown: " .. desc })
  end
  map("<leader>mp", "<cmd>PeekOpen<cr>", "Open [P]review")
  map("<leader>mc", "<cmd>PeekClose<cr>", "[C]lose Preview")
  map("<leader>mt", "<cmd>PeekToggle<cr>", "[T]oggle Preview")
end

-- Folding for markdown sections
vim.wo.foldmethod = "expr"
vim.wo.foldexpr =
  "v:lnum==1?'>1':getline(v:lnum)=~'^#'?'>'.len(matchstr(getline(v:lnum),'^#\\+')):'='"
