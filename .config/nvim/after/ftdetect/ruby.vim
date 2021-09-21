"-----------------------------------------------------------------------------
" Set up omni.
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
" Ruby Debugging
" Make those debugger statements painfully obvious
"-----------------------------------------------------------------------------
augroup highlight_ruby_debug
  au BufEnter *.rb syn match error contained "\<binding.pry\>"
  au BufEnter *.rb syn match error contained "\<debugger\>"
  au BufEnter *.rb syn match error contained "\<byebug\>"
augroup END

augroup ruby_ft
  autocmd!

  autocmd FileType ruby setlocal foldexpr=turboladen#RubyMethodFold(v:lnum)
  autocmd FileType ruby setlocal foldmethod=expr

  autocmd FileType ruby nmap <silent> <leader>r :Dispatch bin/rubocop -a %<CR>
  " Output the command for manually running RSpec for that line.
  autocmd FileType ruby nnoremap <leader>m :call turboladen#RSpecCommandForManualRunning()<CR>
  " puts the caller
  autocmd FileType ruby nnoremap <leader>x oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

  " Reindent whole file
  autocmd FileType ruby nnoremap <leader>= :call turboladen#KeepJumps("gg=G")<CR>
augroup END
