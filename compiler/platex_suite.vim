" Vim compiler file
"
if exists("current_compiler")
  finish
endif
let current_compiler = "platex"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

"" --- Set makeprg {{{
"
let platex_suite_prefix = 
      \ "FILE=$*" .
      \ "\\ TEX=" . g:platex_suite_latex_compiler . 
      \ "\\ BIBTEX=" . g:platex_suite_bibtex_compiler .
      \ "\\ DVIPDF=" . g:platex_suite_dvipdf_compiler
let platex_suite_makeprg = '(' . 
      \ platex_suite_prefix . 
      \ "\\ make\\ -f\\ " . 
      \ g:platex_suite_makefile . ')'
exec ':CompilerSet makeprg=' . platex_suite_makeprg
"}}}

"" --- Set ErrorFormat {{{
"
" Most of the codes below was copied from VIM-LaTeX-Suite.
" Reference: https://github.com/gerw/vim-latex-suite/blob/master/compiler/tex.vim
"

let g:platex_suite_ignored_warnings =
      \ "Underfull\n" .
      \ "Overfull\n" .
      \ "specifier changed to\n" .
      \ "You have requested\n" .
      \ "Missing number, treated as zero.\n" .
      \ "There were undefined reference\n" .
      \ "Citation %.%# undefined"
let g:platex_suite_ignore_level = 3
let g:platex_suite_ignore_unmatched = 1
let g:platex_suite_tex_showalllines = 0

function! s:strntok(s, tok, n)
  return matchstr( a:s.a:tok[0], '\v(\zs([^'.a:tok.']*)\ze['.a:tok.']){'.a:n.'}')
endfun

function! s:ignore_warnings()
  let i = 1
  while s:strntok(g:platex_suite_ignored_warnings, "\n", i) != '' && i <= g:platex_suite_ignore_level
    let warningPat = s:strntok(g:platex_suite_ignored_warnings, "\n", i)
    let warningPat = escape(substitute(warningPat, '[\,]', '%\\\\&', 'g'), ' ')
    exe 'CompilerSet efm+=%-G%.%#'.warningPat.'%.%#'
    let i = i + 1
  endwhile
endfunction

function! s:set_latex_efm()
  let pm = ( g:platex_suite_tex_showalllines == 1 ? '+' : '-' )

  CompilerSet efm=
  " remove default error formats that cause issues with revtex, where they
  " match version messages
  " Reference: http://bugs.debian.org/582100
  CompilerSet efm-=%f:%l:%m
  CompilerSet efm-=%f:%l:%c:%m

  if !g:platex_suite_tex_showalllines
    call s:ignore_warnings()
  endif

  CompilerSet efm+=%E!\ LaTeX\ %trror:\ %m
  CompilerSet efm+=%E!\ %m
  CompilerSet efm+=%E%f:%l:\ %m

  CompilerSet efm+=%+WLaTeX\ %.%#Warning:\ %.%#line\ %l%.%#
  CompilerSet efm+=%+W%.%#\ at\ lines\ %l--%*\\d
  CompilerSet efm+=%+WLaTeX\ %.%#Warning:\ %m

  exec 'CompilerSet efm+=%'.pm.'Cl.%l\ %m'
  exec 'CompilerSet efm+=%'.pm.'Cl.%l\ '
  exec 'CompilerSet efm+=%'.pm.'C\ \ %m'
  exec 'CompilerSet efm+=%'.pm.'C%.%#-%.%#'
  exec 'CompilerSet efm+=%'.pm.'C%.%#[]%.%#'
  exec 'CompilerSet efm+=%'.pm.'C[]%.%#'
  exec 'CompilerSet efm+=%'.pm.'C%.%#%[{}\\]%.%#'
  exec 'CompilerSet efm+=%'.pm.'C<%.%#>%m'
  exec 'CompilerSet efm+=%'.pm.'C\ \ %m'
  exec 'CompilerSet efm+=%'.pm.'GSee\ the\ LaTeX%m'
  exec 'CompilerSet efm+=%'.pm.'GType\ \ H\ <return>%m'
  exec 'CompilerSet efm+=%'.pm.'G\ ...%.%#'
  exec 'CompilerSet efm+=%'.pm.'G%.%#\ (C)\ %.%#'
  exec 'CompilerSet efm+=%'.pm.'G(see\ the\ transcript%.%#)'
  exec 'CompilerSet efm+=%'.pm.'G\\s%#'
  exec 'CompilerSet efm+=%'.pm.'O(%*[^()])%r'
  exec 'CompilerSet efm+=%'.pm.'P(%f%r'
  exec 'CompilerSet efm+=%'.pm.'P\ %\\=(%f%r'
  exec 'CompilerSet efm+=%'.pm.'P%*[^()](%f%r'
  exec 'CompilerSet efm+=%'.pm.'P(%f%*[^()]'
  exec 'CompilerSet efm+=%'.pm.'P[%\\d%[^()]%#(%f%r'
  if g:platex_suite_ignore_unmatched && !g:platex_suite_tex_showalllines
    CompilerSet efm+=%-P%*[^()]
  endif
  exec 'CompilerSet efm+=%'.pm.'Q)%r'
  exec 'CompilerSet efm+=%'.pm.'Q%*[^()])%r'
  exec 'CompilerSet efm+=%'.pm.'Q[%\\d%*[^()])%r'
  if g:platex_suite_ignore_unmatched && !g:platex_suite_tex_showalllines
    CompilerSet efm+=%-Q%*[^()]
  endif
  if g:platex_suite_ignore_unmatched && !g:platex_suite_tex_showalllines
    CompilerSet efm+=%-G%.%#
  endif
endfunction 
call s:set_latex_efm()
"}}}
