require("dapui").setup({})

vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>", {silent = true, noremap = true})
