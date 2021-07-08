"-------------------------
" fzf
" https://github.com/junegunn/dotfiles/blob/da378217ad008d422bc5b577802cad237a2930e1/vimrc#L1197
"-------------------------
set runtimepath+=/usr/local/opt/fzf

let $FZF_DEFAULT_COMMAND='rg --files --vimgrep'
let $FZF_DEFAULT_OPTS='--layout=reverse --inline-info --border=horizontal --height=5'

let g:fzf_command_prefix = 'Fzf'

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <leader><leader> :FzfFiles<CR>
nnoremap <silent> <leader><CR> :FzfBuffers<CR>

" nnoremap <silent> <leader><leader> :FzfGitFiles<CR>
" nnoremap <silent> <leader><leader> :FzfSearch<CR>
" nnoremap <silent> <leader><C-m> :Maps<CR>
