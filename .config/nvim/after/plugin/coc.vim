augroup coc
  autocmd!

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" https://kimpers.com/vim-intelligent-autocompletion/
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
" nmap <silent> <leader>] <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [G <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]G <Plug>(coc-diagnostic-next-error)
nmap <silent> g= <Plug>(coc-format)

" Remap for rename current word
nmap <silent> rn <Plug>(coc-rename)
nmap gA <Plug>(coc-codeaction-line)
vmap gA <Plug>(coc-codeaction-selected)
nmap gB <Plug>(coc-codeaction-cursor)
vmap gB <Plug>(coc-codeaction)
nmap gF <Plug>(coc-fix-current)
nmap <silent> gR <Plug>(coc-refactor)

" Show all diagnostics.
nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

nnoremap <leader>/ :CocSearch<SPACE>

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"--
" For coc-snippets
"--
" https://github.com/neoclide/coc-snippets
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

"-------------------------
" neoclide/coc-git
"-------------------------
set signcolumn=yes
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)

"-------------------------
" neoclide/coc-prettier
"-------------------------
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"-------------------------
" FileType specific settings
"-------------------------
augroup coc_rust
  autocmd!

  autocmd FileType rust nmap <silent> gO :CocCommand rust-analyzer.openDocs<cr>
  autocmd FileType rust nmap <leader>ra :CocCommand rust-analyzer.
  autocmd FileType rust nmap <leader>rt :CocCommand rust-analyzer.run<cr>
  autocmd FileType rust vnoremap gJ :CocCommand rust-analyzer.joinLines<cr>
augroup END
