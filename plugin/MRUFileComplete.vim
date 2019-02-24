" MRUFileComplete.vim: Completion from last used files.
"
" DEPENDENCIES:
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_MRUFileComplete') || (v:version < 700)
    finish
endif
let g:loaded_MRUFileComplete = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:MRUFileComplete_MRUGenerator')
    if v:version < 702 | runtime autoload/MRUFileComplete/viminfo.vim | endif  " The Funcref doesn't trigger the autoload in older Vim versions.
    let g:MRUFileComplete_MRUGenerator = function('MRUFileComplete#viminfo#NumberedMarks')
endif


"- mappings --------------------------------------------------------------------

inoremap <silent> <expr> <Plug>(MRUFileComplete) MRUFileComplete#Expr()
nnoremap <script> <expr> <SID>(MRUFileComplete) MRUFileComplete#Selected()
" Note: Must leave selection first; cannot do that inside the expression mapping
" because the visual selection marks haven't been set there yet.
vnoremap <silent> <script> <Plug>(MRUFileComplete) <C-\><C-n><SID>(MRUFileComplete)
if ! hasmapto('<Plug>(MRUFileComplete)', 'i')
    imap <C-x><C-r> <Plug>(MRUFileComplete)
endif
if ! hasmapto('<Plug>(MRUFileComplete)', 'v')
    vmap <C-x><C-r> <Plug>(MRUFileComplete)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
