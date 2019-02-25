" Test completion from selected base.

call MRUFileComplete#Expr() " Initialize script variables.
let g:SelectBase = 'call MRUFileComplete#Selected()'
edit input.txt

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(2)

call IsMatchesInContext('', '', '; b', ['; browse'], 'match for ; b')
call IsMatchesInContext('<<<', '>>>', '"t', ['"there', '"those'], 'match for "t')

call vimtest#Quit()
