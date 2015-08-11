scriptencoding utf-8
" end_of_line {{{1

" >>> call editorconfig#end_of_line#execute('lf')
"
"
" >>> call editorconfig#end_of_line#execute('lfcr')
" Vim(echoerr):editorconfig: unsupported value: end_of_line=lfcr

function! editorconfig#end_of_line#execute(value)
  " 'lf', 'cr' or 'crlf'
  try
    execute s:end_of_line[tolower(a:value)]
  catch /^Vim\%((\a\+)\)\=:E716/
    echoerr printf('editorconfig: unsupported value: end_of_line=%s', a:value)
  endtry
endfunction

let s:end_of_line =
      \ { 'lf': 'setlocal fileformat=unix'
      \ , 'cr': 'setlocal fileformat=mac'
      \ , 'crlf': 'setlocal fileformat=dos'
      \ }
" 1}}}
