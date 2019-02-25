" Test repeat of completion from MRU files.

runtime tests/helpers/insert.vim
new

call SetCompletion("\<C-x>\<C-r>")
call SetCompleteExpr('MRUFileComplete#Expr')

call InsertRepeat('fo', 1)
call InsertRepeat('foob', 0, 0, 0, 0)
call InsertRepeat('Th', 0, 2, 0, 0)

call vimtest#SaveOut()
call vimtest#Quit()
