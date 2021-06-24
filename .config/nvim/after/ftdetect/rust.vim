augroup rust_ft
  autocmd!

  autocmd FileType rust setlocal colorcolumn=100
  autocmd FileType rust setlocal colorcolumn=100
  autocmd FileType rust setlocal foldmethod=expr
  autocmd FileType rust setlocal foldexpr=GetRustFold(v:lnum)
  " nmap <silent> <leader>s :TestNearest<CR>
  autocmd FileType rust nnoremap <leader>cc :Dispatch cargo check --all-features<CR>
  autocmd FileType rust nmap <silent> gO :CocCommand rust-analyzer.openDocs<cr>
  autocmd FileType rust nmap <leader>ra :CocCommand rust-analyzer.
augroup END
