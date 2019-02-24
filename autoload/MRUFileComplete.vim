" MRUFileComplete.vim: Completion from last used files.
"
" DEPENDENCIES:
"   - ingo-library.vim plugin
"   - CompleteHelper.vim plugin
"
" Copyright: (C) 2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
let s:save_cpo = &cpo
set cpo&vim

function! s:GetMRUFiles()
    return call(g:MRUFileComplete_MRUGenerator, [])
endfunction

let s:repeatCnt = 0
function! MRUFileComplete#MRUFileComplete( findstart, base ) abort
    if s:repeatCnt
	if a:findstart
	    return col('.') - 1
	else
	    let l:matches = []
	    call CompleteHelper#FindMatches(l:matches,
	    \   CompleteHelper#Repeat#GetPattern(s:fullText),
	    \   {'complete': '', 'filespecs': s:GetMRUFiles(), 'processor': function('CompleteHelper#Repeat#Processor')}
	    \)
	    if empty(l:matches)
		call CompleteHelper#Repeat#Clear()
	    endif
	    return l:matches
	endif
    endif

    if a:findstart
	" Locate the start of the keyword under cursor.
	let l:startCol = searchpos('\k*\%#', 'bn', line('.'))[1]
	if l:startCol == 0
	    let l:startCol = col('.')
	endif
	return l:startCol - 1 " Return byte index, not column.
    else
	" Find matches starting with a:base.
	let l:matches = []
	call CompleteHelper#FindMatches(l:matches, '\V' . ingo#regexp#MakeStartWordSearch(escape(a:base, '\')) . '\k\+', {'complete': '', 'filespecs': s:GetMRUFiles()})
	return l:matches
    endif
endfunction

function! MRUFileComplete#Expr() abort
    set completefunc=MRUFileComplete#MRUFileComplete

    let s:repeatCnt = 0 " Important!
    let [s:repeatCnt, l:addedText, s:fullText] = CompleteHelper#Repeat#TestForRepeat()

    return "\<C-x>\<C-u>"
endfunction
function! MRUFileComplete#Selected() abort
    call MRUFileComplete#Expr()
    let s:selectedBaseCol = col("'<")

    return "g`>" . (col("'>") == (col('$')) ? 'a' : 'i') . "\<C-x>\<C-u>"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
