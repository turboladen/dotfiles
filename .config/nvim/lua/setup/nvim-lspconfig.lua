require("turboladen.lsp").setup_lsp()

-- autocmd BufWritePost * lua vim.lsp.buf.formatting_sync()
vim.cmd(
  [[
augroup lsp_format_config
  autocmd!
  autocmd BufReadPost * lua require("fidget").setup({})
augroup end
]]
)
