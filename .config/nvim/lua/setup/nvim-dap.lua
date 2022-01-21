local dap = require("dap")

dap.adapters.ruby = {
    type = "executable",
    command = "readapt",
    args = {"stdio"}
}

dap.configurations.ruby = {
    {
        type = "ruby",
        request = "launch",
        name = "Ruby",
        program = "bundle",
        programArgs = {"exec", "rspec"},
        useBundler = true
    }
}

vim.fn.sign_define("DapBreakpoint", {text = "🛑", texthl = "", linehl = "", numhl = ""})

vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>dk", "<cmd>lua require('dap').step_out()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>dl", "<cmd>lua require('dap').step_into()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>dj", "<cmd>lua require('dap').step_over()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<leader>dB",
    "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    {noremap = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>lp",
    "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    {noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>dL", "<cmd>lua require('dap').run_last()<CR>", {noremap = true})
vim.api.nvim_set_keymap(
    "n",
    "<leader>di",
    "<cmd>lua require('dap.ui.variables').hover()<CR>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
    "v",
    "<leader>di",
    "<cmd>lua require('dap.ui.variables').visual_hover()<CR>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>d?",
    "<cmd>lua require('dap.ui.variables').scopes()<CR>",
    {silent = true, noremap = true}
)
vim.api.nvim_set_keymap(
    "n",
    "<leader>de",
    "<cmd>lua require('dap').set_exception_breakpoints({'all'})<CR>",
    {noremap = true}
)

-- au FileType dap-repl lua require('dap.ext.autocompl').attach()
vim.cmd [[autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
