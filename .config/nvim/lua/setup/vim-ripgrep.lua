vim.g.rg_command = "rg --vimgrep --ignore-vcs"
-- vim.g.rg_highlight = 1

vim.api.nvim_set_keymap("n", "<leader>.", ":Rg<SPACE>", {noremap = true})
