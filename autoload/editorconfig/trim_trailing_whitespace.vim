scriptencoding utf-8

" trim_trailing_whitespace {{{1

" >>> silent! new ./test.text
" >>> call editorconfig#trim_trailing_whitespace#execute('true')
" >>> execute "normal! :silent 0insert\<CR>abcde\<Space>\<CR>"
" >>> execute "normal! :silent w\<CR>"
" "test.text" [New] 1L, 7C written
" >>> echo getline(1)
" abcde
" >>> bwipeout test.text
" >>> execute "normal! :call delete('./test.text')\<CR>"

function! editorconfig#trim_trailing_whitespace#execute(value) abort
  " 'true' or 'false'
  if a:value is# 'true'
    autocmd plugin-editorconfig-local BufWritePre <buffer> call s:do_trim_trailing_whitespace()
  elseif a:value is# 'false'
  elseif get(g:, 'editorconfig_verbose', 0)
    echoerr printf('editorconfig: unsupported value: trim_trailing_whitespace=%s', a:value)
  endif
endfunction

function! s:do_trim_trailing_whitespace() abort "{{{
  " check if file size greater than editorconfig_max_file_size
  let l:size = get(g:, 'editorconfig_max_file_size', 1024*1024)
  let l:max_lines = get(g:, 'editorconfig_max_lines', 10000)
  if getfsize(expand('<afile>')) > l:size || line('$') > l:max_lines
    return
  endif
  let view = winsaveview()
  try
    keeppatterns %s/\s\+$//e
  finally
    call winrestview(view)
  endtry
endfunction "}}}
" 1}}}
