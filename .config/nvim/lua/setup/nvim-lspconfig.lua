require("turboladen.lsp").setup_lsp()

vim.cmd(
    [[
augroup lsp_format_config
  autocmd!
  autocmd BufWritePost * lua vim.lsp.buf.formatting_sync()
  autocmd BufReadPost * lua require("fidget").setup({})
augroup end
]]
)
