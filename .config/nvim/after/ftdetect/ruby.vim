"-----------------------------------------------------------------------------
" vim-ruby settings
"-----------------------------------------------------------------------------
let g:ruby_operators = 1
let g:ruby_spellcheck_strings = 1
let g:ruby_space_errors = 1

"-----------------------------------------------------------------------------
" Set up folding.
"-----------------------------------------------------------------------------
let g:ruby_fold = 1

"-----------------------------------------------------------------------------
" Set up omni.
"-----------------------------------------------------------------------------
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
" let g:rubycomplete_rails = 1
let g:rubycomplete_load_gemfile = 1

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

  autocmd FileType ruby nmap <silent> <leader>r :!bin/rubocop -a %<CR>
  " Output the command for manually running RSpec for that line.
  autocmd FileType ruby nnoremap <leader>m :call turboladen#RSpecCommandForManualRunning()<CR>
  " puts the caller
  autocmd FileType ruby nnoremap <leader>x oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

  " Reindent whole file
  autocmd FileType ruby nnoremap <leader>= :call turboladen#KeepJumps("gg=G")<CR>

  "-----
  " janko-m/vim-test
  "-----
  autocmd FileType ruby nnoremap <silent> <leader>t :TestFile<CR>
  autocmd FileType ruby nnoremap <silent> <leader>t :TestNearest<CR>
  autocmd FileType ruby nnoremap <silent> <leader>l :TestLast<CR>
  autocmd FileType ruby nnoremap <silent> <leader>s :TestSuite<CR>

augroup END

"-----------------------------------------------------------------------------
" yardoc
"-----------------------------------------------------------------------------
hi link yardGenericTag rubyInstanceVariable
hi link yardTypeList rubyConstant
hi link yardType rubyConstant
