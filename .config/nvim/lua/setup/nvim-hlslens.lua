vim.api.nvim_set_keymap(
    "n",
    "n",
    "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>",
    {silent = true, noremap = true}
)

vim.api.nvim_set_keymap(
    "n",
    "N",
    "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "*", "*<cmd>lua require('hlslens').start()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "#", "#<cmd>lua require('hlslens').start()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "g*", "g*<cmd>lua require('hlslens').start()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "g#", "g#<cmd>lua require('hlslens').start()<CR>", {noremap = true})
