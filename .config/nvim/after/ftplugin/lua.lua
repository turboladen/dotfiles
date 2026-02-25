-- Lua-specific settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true
vim.bo.commentstring = "-- %s"

-- Folding for better code organization
vim.wo.foldmethod = "expr"
vim.wo.foldexpr =
  "v:lnum==1?'>1':getline(v:lnum)=~'^\\s*--'&&getline(v:lnum+1)=~'^\\s*[^-]'?'>1':getline(v:lnum)=~'^\\s*}'?'<1':getline(v:lnum)=~'^\\s*{'?'>1':'='"
