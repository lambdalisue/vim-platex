compiler platex_suite

command! -complete=customlist,s:CompletionCompileCommands -nargs=? -range=%
      \ Preview :call platex_suite#Preview(<f-args>)
command! -complete=customlist,s:CompletionCompileCommands -nargs=? -range=%
      \ Compile :call platex_suite#Compile(<f-args>)
function! s:CompletionCompileCommands(ArgLead, CmdLine, CusorPos)
  let l:cmd = split(a:CmdLine)
  let l:arg = get(l:cmd, 1, '')
  let l:lst = split(glob(l:arg.'**/*.tex'), '\n')
  " too large list will break completion... I don't know better way
  " to ignore these files. (I wonder if I can limit glob by directory level.)
  return l:lst[0:10]
endfunction

nnoremap <Plug>(platex_suite_compile) :call platex_suite#Compile("")
nnoremap <Plug>(platex_suite_preview) :call platex_suite#Preview("")

if !hasmapto('<Plug>(platex_suite_preview)', 'n')
  nmap <F12> <Plug>(platex_suite_preview)<CR>
endif
if !hasmapto('<Plug>(platex_suite_compile)', 'n')
  nmap <F5> <Plug>(platex_suite_compile)<CR>
endif
