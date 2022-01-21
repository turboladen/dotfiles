require("trouble").setup(
    {
        -- auto_preview = false,
        auto_close = true
    }
)

local opts = {silent = true, noremap = true}
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", opts)

vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xr", "<cmd>TroubleRefresh<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xR", "<cmd>TroubleToggle lsp_references<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xD", "<cmd>TroubleToggle lsp_definitions<cr>", opts)
vim.api.nvim_set_keymap("n", "<leader>xT", "<cmd>TroubleToggle lsp_type_definitions<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
-- vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)

-- jump to the next item, skipping the groups
vim.api.nvim_set_keymap(
    "n",
    "<leader>]",
    "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>",
    opts
)

-- jump to the previous item, skipping the groups
vim.api.nvim_set_keymap(
    "n",
    "<leader>[",
    "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>",
    opts
)
