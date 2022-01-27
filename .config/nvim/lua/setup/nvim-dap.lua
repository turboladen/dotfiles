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

-- au FileType dap-repl lua require('dap.ext.autocompl').attach()
vim.cmd [[autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
