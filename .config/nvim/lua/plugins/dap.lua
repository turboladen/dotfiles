-- ╭─────────────────────────────────────────────────────────╮
-- │ Debug Adapter Protocol client implementation for Neovim │
-- ╰─────────────────────────────────────────────────────────╯
-- NOTES!
-- 1. To debug rust stuff, I'm using rust-tools setup... which means, I need to run :RustDebuggables
--    instead of pressing F5.

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

-- au FileType dap-repl lua require('dap.ext.autocompl').attach()
-- vim.cmd [[autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()]]
