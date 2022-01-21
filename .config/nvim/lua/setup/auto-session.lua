vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,resize,winpos,terminal"

require("auto-session").setup(
    {
        pre_save_cmds = {
            ":Bdelete hidden",
            ":UltestSummaryClose",
            ":TroubleClose"
        },
        auto_save_enabled = true,
        auto_restore_enabled = false
    }
)

vim.api.nvim_set_keymap("n", "<leader>sr", ":RestoreSession<CR>", {noremap = true, silent = true})
