require("telescope").setup(
    {
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = require("telescope.actions").close
                }
            }
        },
        pickers = {
            buffers = {
                theme = "cursor",
                previewer = false
            },
            find_files = {
                theme = "dropdown",
                previewer = false
            },
            lsp_code_actions = {
                theme = "cursor",
                layout_config = {height = 15}
            },
            oldfiles = {
                theme = "dropdown"
            }
        }
    }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><space>",
    "<cmd>lua require('telescope.builtin').find_files()<CR>",
    {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
    "n",
    "<leader><CR>",
    "<cmd>lua require('telescope.builtin').buffers()<CR>",
    {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>/",
    "<cmd>lua require('telescope.builtin').live_grep()<CR>",
    {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fk",
    "<cmd>lua require('telescope.builtin').grep_string()<CR>",
    {noremap = true, silent = true}
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fm",
    "<cmd>lua require('telescope.builtin').marks()<CR>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>fo",
    "<cmd>lua require('telescope.builtin').oldfiles()<CR>",
    {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ft",
    "<cmd>lua require('telescope.builtin').grep_string({ search = 'TODO' })<CR>",
    {noremap = true, silent = true}
)

-- telescope-github.nvim
require("telescope").load_extension("gh")

vim.api.nvim_set_keymap("n", "<leader>ghi", "<cmd>Telescope gh issues<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ghp", "<cmd>Telescope gh pull_request<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ghg", "<cmd>Telescope gh gist<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ghr", "<cmd>Telescope gh run<CR>", {noremap = true})
-- vim.api.nvim_set_keymap("n", "<leader>gh", "<cmd>Telescope gh ", {noremap = true})
