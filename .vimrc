set visualbell
set t_vb=

call plug#begin()
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/andreasvc/vim-256noir'
Plug 'vim-autoformat/vim-autoformat'
call plug#end()

" Autoformat configuration.

let g:formatdef_clangformat = '"clang-format --style=file"'
let g:formatters_c = ['clangformat']
let g:formatters_h = ['clangformat']
