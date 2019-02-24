" MRUFileComplete/viminfo.vim: Use numbered file marks as source.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
let s:save_cpo = &cpo
set cpo&vim

function! s:GetMarks( marks ) abort
    redir => l:marksOutput
	silent! execute 'marks' a:marks
    redir END
    redraw  " This is necessary because of the :redir done earlier.

    return split(l:marksOutput, "\n")[1:] " The first line contains the header.
endfunction
function! s:GetNumberedMarkFilespecs() abort
    return map(
    \   s:GetMarks('0123456789'),
    \   'matchstr(v:val, ''^\s*\([a-zA-Z0-9''''`"[\]<>^.(){}]\+\)\s\+\(\d\+\)\s\+\(\d\+\)\s\+\zs\(.*\)$'')'
    \)
endfunction
function! MRUFileComplete#viminfo#NumberedMarks() abort
    return filter(
    \   ingo#compat#uniq(
    \       map(s:GetNumberedMarkFilespecs(), 'fnamemodify(v:val, ":p")')
    \   ),
    \   'filereadable(v:val)'
    \)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
