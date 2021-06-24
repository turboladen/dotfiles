let g:coc_node_path = '/usr/local/bin/node'

" coc-dictionary: Words from files in &dictionary.
" coc-git: Somewhat replaces gitgutter; kinda depends on vim-fugitive.
" coc-html: HTML language server.
" coc-lists: Some basic list sources
" coc-prettier: Code reformatting--initially got for markdown
"
let g:coc_global_extensions = [
  \ 'coc-dictionary',
  \ 'coc-git',
  \ 'coc-html',
  \ 'coc-lists',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-rust-analyzer',
  \ 'coc-solargraph',
  \ 'coc-snippets',
  \ 'coc-toml',
  \ 'coc-yaml'
\ ]

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
