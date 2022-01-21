-- vim.api.nvim_exec(
--     [[function! g:OpenUltest(file_path)
--     :UltestSummaryOpen
--     endfunction
-- ]],
--     false
-- )
vim.g.ultest_use_pty = 1

vim.g.ultest_virtual_text = 1
-- vim.g.ultest_pre_run = "g:OpenUltest"
-- local nf_mdi_run_fast = "省"
-- local nf_fa_angle_double_right = ""
local nf_fa_hourglass_1 = ""
vim.g.ultest_running_sign = nf_fa_hourglass_1

vim.cmd(
    [[
                        augroup UltestSetup
                            autocmd!
                            autocmd FileType ruby,rust nmap ]t <Plug>(ultest-next-fail)
                            autocmd FileType ruby,rust nmap [t <Plug>(ultest-prev-fail)
                            autocmd FileType ruby,rust nnoremap <silent> <leader>tu <cmd>Ultest<CR>
                            autocmd FileType ruby,rust nnoremap <silent> <leader>tt <cmd>UltestSummary<CR>
                        augroup END
                    ]]
)
