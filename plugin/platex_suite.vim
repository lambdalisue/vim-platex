if &cp || (exists('g:loaded_platex_suite') && g:loaded_platex_suite)
  finish
endif
let g:loaded_platex_suite = 1

let s:save_cpo = &cpo
set cpo&vim

let s:path = expand('<sfile>:p:h')
function! s:define(name, value)
  " Define an global variable if not defined previously
  if !exists('g:' . a:name)
    exec 'let g:' . a:name . ' = "' . a:value . '"'
  endif
endfunction

call s:define('platex_suite_main_file', 'index')
call s:define('platex_suite_latex_compiler', 'platex')
call s:define('platex_suite_bibtex_compiler', 'bibtex')
call s:define('platex_suite_dvipdf_compiler', 'dvipdfmx')
call s:define('platex_suite_makefile', s:path . '/../scripts/platex-suite.make')
if !exists('g:platex_suite_pdf_viewer')
  if has('mac')
    let g:platex_suite_pdf_viewer = 'open'
  elseif has('unix')
    let g:platex_suite_pdf_viewer = 'evince'
  endif
endif

call s:define('platex_suite_ignored_warnings', 
      \ "Underfull\n" .
      \ "Overfull\n" .
      \ "specifier changed to\n" .
      \ "You have requested\n" .
      \ "Missing number, treated as zero.\n" .
      \ "There were undefined reference\n" .
      \ "Citation %.%# undefined")
call s:define('platex_suite_ignore_level', 7)
call s:define('platex_suite_ignore_unmatched', 1)
call s:define('platex_suite_tex_showalllines', 0)

let &cpo = s:save_cpo
unlet s:save_cpo
