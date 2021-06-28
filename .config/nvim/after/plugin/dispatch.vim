augroup dispatch_ruby
  autocmd!

  autocmd FileType ruby nnoremap <leader>b :Dispatch bundle install<CR>
augroup END

augroup dispatch_rust
  autocmd!

  autocmd FileType rust nnoremap <leader>cc :Dispatch cargo check --all-features<CR>
augroup END
