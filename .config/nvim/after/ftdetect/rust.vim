augroup rust_ft
  autocmd!

  autocmd FileType rust setlocal colorcolumn=100
  autocmd FileType rust nnoremap <silent> <leader>r :CocCommand rust-analyzer.run<CR>
augroup END
