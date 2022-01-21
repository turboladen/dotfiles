vim.g.floaterm_wintype = "split"
vim.g.floaterm_autoclose = 1
vim.g.floaterm_autoinsert = false
vim.g.floaterm_height = 0.3

vim.g["test#strategy"] = {
    nearest = "floaterm",
    last = "floaterm",
    file = "dispatch",
    suite = "dispatch"
}
vim.g["test#preserve_screen"] = 1
vim.g["test#enabled_runners"] = {
    "ruby#rspec",
    "ruby#rails",
    "rust#cargotest"
}

vim.cmd(
    [[
                        augroup VimTestSetup
                            autocmd!
                            autocmd FileType ruby,rust nnoremap <silent> <leader>tn <cmd>TestNearest<CR>
                            autocmd FileType ruby,rust nnoremap <silent> <leader>tf <cmd>TestFile<CR>
                            autocmd FileType ruby,rust nnoremap <silent> <leader>ta <cmd>TestSuite<CR>
                            autocmd FileType ruby,rust nnoremap <silent> <leader>tl <cmd>TestLast<CR>
                            autocmd FileType ruby,rust nnoremap <silent> <leader>tv <cmd>TestVisit<CR>
                        augroup END
                    ]]
)
