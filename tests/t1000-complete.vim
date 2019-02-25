" Test completion from MRU files.

edit input.txt
call MRUFileComplete#Expr() " Initialize script variables.

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(4)

call IsMatchesInIsolatedLine('doesnotexist', [], 'no matches for doesnotexist')
call IsMatchesInIsolatedLine('qui', ['quick'], 'match from fox.txt for qui')
call IsMatchesInIsolatedLine('fo', ['foobar', 'fox'], 'matches from both for fo')
call IsMatchesInIsolatedLine('la', ['labradors', 'laziputians', 'lazy'], 'matches from both for la')

call vimtest#Quit()
