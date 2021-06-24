scriptencoding utf-8

"-------------------------
" ale
"-------------------------
let g:ale_fix_on_save = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_disable_lsp = 1

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

let g:ale_linters = {
  \ 'markdown': ['proselint', 'writegood'],
  \ 'vim': ['vint'],
  \ }

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'ruby': ['rubocop'],
  \ 'rust': ['rustfmt']
  \ }
