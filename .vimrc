" Dependency list:
" - vim-plug
" For Rust:
" - rust-analyzer is installed and callable from a terminal
" For C/C++:
" - clangd is installed and callable from a terminal
" For Python:
" - black is installed and callabe from a terminal
" - python3-flake8 is installed
" - python3-pycodestyle is installed
" For ordinary text files:
" - formattxt must is installed.

set visualbell
set t_vb=

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'vim-autoformat/vim-autoformat'
Plug 'Badacadabra/vim-archery'
Plug 'itchyny/lightline.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'sphamba/smear-cursor.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'master', 'do': ':TSUpdate'} " This line took me ~3 hours to write :P
call plug#end()

" Treesitter (syntax highlighting)
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "python" }, -- languages to install
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Cursor smear.
lua require('smear_cursor').enabled = true
lua require('smear_cursor').setup()

" Autoformat configuration.
let g:formatdef_clangformat = '"clang-format --style=file"'
let g:formatters_c = ['clangformat']
let g:formatters_h = ['clangformat']
let g:formatters_cpp = ['clangformat']
let g:formatters_hpp = ['clangformat']

let g:formatdef_textformat = '"formattxt -w 80"'
let g:formatters_text = ['textformat']

let g:formatdef_customblack = '"black --preview -l 79 -"'

let g:formatters_python = ['customblack']
noremap <F3> :Autoformat<CR>

"clangd language server setup.
if executable('clangd')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'clangd',
		\ 'cmd': ['clangd'],
        	\ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

"Rust language server setup.
if executable('rust-analyzer')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'rust-analyzer',
		\ 'cmd': ['rust-analyzer'],
		\ 'allowlist': ['rust'],
		\})
endif

"Python language server setup.
if executable('pylsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': ['pylsp'],
        \ 'allowlist': ['python'],
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
set nowrap
