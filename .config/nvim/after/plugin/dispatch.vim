augroup dispatch_rust
  autocmd!

  autocmd FileType rust nnoremap <leader>cc :Dispatch cargo check --all-features<CR>
augroup END
