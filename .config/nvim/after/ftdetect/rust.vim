augroup rust_ft
  autocmd!

  autocmd FileType rust setlocal colorcolumn=100
  autocmd FileType rust nnoremap<silent> <leader>r :lua require('rust-tools.runnables').runnables()<CR>
  autocmd FileType rust nnoremap<silent> K :lua require('rust-tools.hover_actions').hover_actions()<CR>
  autocmd FileType rust nnoremap<silent> gJ :lua require('rust-tools.join_lines').join_lines()<CR>
  autocmd FileType rust nnoremap <leader>ex :lua require('rust-tools.expand_macro').expand_macro()<CR>
augroup END
