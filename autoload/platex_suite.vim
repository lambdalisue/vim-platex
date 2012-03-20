let s:save_cpo = &cpo
set cpo&vim

    
function! platex_suite#Compile(...)
  let filename = a:0 ? a:1 : g:platex_suite_main_file
  let filename = expand(filename)
  let filename = fnamemodify(filename, ":r")
  exec ":w"
  exec ":make " . filename
endfunction

function! platex_suite#Preview(...)
  if !exists('g:platex_suite_pdf_viewer')
    echo "g:platex_suite_pdf_viewer has not specified."
    echo "you must specify this variable to use preview feature."
    return
  endif
  if a:0
    call platex_suite#Compile(a:1)
  else
    call platex_suite#Compile()
  endif
  silent exec "!" . g:platex_suite_pdf_viewer . " '" . g:platex_suite_main_file . ".pdf'&"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
