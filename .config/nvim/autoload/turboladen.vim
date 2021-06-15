"###############################################################################
"
" This file contains all of my own non-plugin-specific functions.
"
"###############################################################################
" Builds a the RSpec command for running the test on your current line, then
" echos it and copies it to the system clipboard. Useful for when wanting to
" run the same test in a different terminal.
function! turboladen#RSpecCommandForManualRunning() abort
  set clipboard=unnamed
  let l:currentLine = line('.')
  let l:command = turboladen#RSpecShellCommand() . expand('%') . ':' . l:currentLine

  " Copy to system clipboard
  let @+ = l:command
  echo l:command
endfunction

""
" Returns the RSpec command to run based on your environment.
function! turboladen#RSpecShellCommand() abort
  if filereadable('bin/rspec')
    return 'bin/rspec '
  else
    return 'bundle exec rspec '
  endif
endfunction

function! turboladen#RSpecVimCommand() abort
  let l:cmd = turboladen#RSpecShellCommand()

  " Use vim-dispatch to run tests in a tmux window
  return 'Dispatch ' . l:cmd . ' {spec}'
endfunction

function! turboladen#SetUpTurboladenDocs() abort
  !cp '/Users/steve.loveless/Development/projects/config_files/vim/doc/turboladen.txt' '/Users/steve.loveless/.vim/doc/turboladen.txt'
  " :helptags l:vim_doc_dir
  :helptags /Users/steve.loveless/.vim/doc
endfunction

""
" Clean out the whitespaces from the file.
" function! <SID>turboladen#StripTrailingWhitespaces()
function! turboladen#StripTrailingWhitespaces() abort
  " Preparation: save last search, and cursor position.
  let l:_s=@/
  let l:l = line('.')
  let l:c = col('.')
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=l:_s
  call cursor(l:l, l:c)
endfunction

function! turboladen#TabularizeHashArgs() abort
  :Tabularize /\w\+\: .\+$
endfunction
