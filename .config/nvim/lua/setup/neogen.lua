require("neogen").setup({})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ng", "<cmd>lua require('neogen').generate()<CR>", opts)

vim.keymap.set("i", "<C-l>", "<cmd>lua require('neogen').jump_next()<CR>", opts)
vim.keymap.set("i", "<C-h>", "<cmd>lua require('neogen').jump_prev()<CR>", opts)
