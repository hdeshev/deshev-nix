let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_autoshowtag = 1

set showfulltag

" ctags-filter is a wrapper script that filters 'tags' missed by our
" TypeScript ctags regexes e.g.:
"
" ctags $@ | egrep -v '^(if|for|while|switch|super)\b'
let g:tagbar_type_typescript = {
    \ 'ctagstype' : 'typescript',
    \ 'ctagsbin' : 'ctags-filter',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'i:interfaces',
        \ 'm:members',
        \ 'f:functions',
        \ 'v:variables',
    \ ]
\ }

let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'typescript',
    \ 'ctagsbin' : 'ctags-filter',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'i:interfaces',
        \ 'm:members',
        \ 'f:functions',
        \ 'v:variables',
    \ ]
\ }

let g:tagbar_type_css = {
    \ 'ctagstype' : 'css',
    \ 'ctagsbin' : 'ctags',
    \ 'kinds'     : [
        \ 'c:class',
        \ 'i:id',
        \ 't:tag',
    \ ]
\ }
