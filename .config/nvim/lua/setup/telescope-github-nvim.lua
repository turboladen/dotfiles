require("telescope").load_extension("gh")

vim.api.nvim_set_keymap("n", "<leader>ghi", "<cmd>Telescope gh issues<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ghp", "<cmd>Telescope gh pull_request<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ghg", "<cmd>Telescope gh gist<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ghr", "<cmd>Telescope gh run<CR>", {noremap = true})
