call vimtest#AddDependency('vim-ingo-library')
call vimtest#AddDependency('vim-CompleteHelper')

let s:scriptDir = expand('<sfile>:p:h')
function! Generator() abort
    return map(['foo.txt', 'fox.txt'], 'ingo#fs#path#Combine(s:scriptDir, v:val)')
endfunction
let g:MRUFileComplete_MRUGenerator = function('Generator')

runtime plugin/MRUFileComplete.vim
