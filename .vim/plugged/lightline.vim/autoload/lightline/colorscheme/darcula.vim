" =============================================================================
" Filename: autoload/lightline/colorscheme/darcula.vim
" Author: kkopec
" License: MIT License
" Last Change: 2017/02/11 21:18:54.
" =============================================================================

let s:black = [ '#2b2b2b', 235 ]
let s:gray = [ '#44475a', 236 ]
let s:white = [ '#bfbfbf', 250 ]
let s:blue = [ '#8be9fd' , 67 ] 
let s:green = [ '#50fa7b', 71 ] 
let s:purple = [ '#bd93f9', 104 ]
let s:red = [ '#ff5555', 204 ]
let s:yellow = [ '#f1fa8c', 222 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:black, s:purple ], [ s:purple, s:gray ] ]
let s:p.normal.right = [ [ s:black, s:green ], [ s:gray, s:purple ] ]
let s:p.inactive.left =  [ [ s:black, s:blue ], [ s:blue, s:gray ] ]
let s:p.inactive.right = [ [ s:black, s:blue ], [ s:blue, s:gray ] ]
let s:p.insert.left = [ [ s:black, s:green ], [ s:green, s:gray ] ] 
let s:p.insert.right = [ [ s:black, s:green ], [ s:green, s:gray ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:red, s:gray ] ]
let s:p.replace.right = [ [ s:black, s:red ], [ s:red, s:gray ] ]
let s:p.visual.left = [ [ s:black, s:yellow ], [ s:yellow, s:gray ] ]
let s:p.visual.right = [ [ s:black, s:yellow ], [ s:yellow, s:gray ] ]
let s:p.normal.middle = [ [ s:white, s:gray ] ]
let s:p.inactive.middle = [ [ s:white, s:gray ] ]
let s:p.tabline.left = [ [ s:blue, s:gray ] ]
let s:p.tabline.tabsel = [ [ s:black, s:blue ] ]
let s:p.tabline.middle = [ [ s:blue, s:gray ] ]
let s:p.tabline.right = [ [ s:black, s:blue ] ]
let s:p.normal.error = [ [ s:red, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]

let g:lightline#colorscheme#darcula#palette = lightline#colorscheme#flatten(s:p)
