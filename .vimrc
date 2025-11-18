" vim-plug is the only dependency. Once that's installed, everything else
" should happen automatically. You'll also need a .clang-format file for
" autoformatting to work.

set visualbell
set t_vb=

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'vim-autoformat/vim-autoformat'
Plug 'Badacadabra/vim-archery'
Plug 'itchyny/lightline.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
call plug#end()

" Autoformat configuration.
let g:formatdef_clangformat = '"clang-format --style=file"'
let g:formatters_c = ['clangformat']
let g:formatters_h = ['clangformat']
let g:formatters_cpp = ['clangformat']
let g:formatters_hpp = ['clangformat']
noremap <F3> :Autoformat<CR>

"clangd language server setup.
if executable('clangd')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'clangd',
		\ 'cmd': ['clangd'],
        	\ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

"  Lightline configuration.
set laststatus=2
set noshowmode
let g:lightline = {'colorscheme': 'wombat'}

" NERDTree configuration.
au VimEnter * NERDTree
noremap <F2> :NERDTreeToggle<CR>

" Generic VIM crap.
set relativenumber
set mouse=a
set splitright
set splitbelow
set tabstop=4
set shiftwidth=4
