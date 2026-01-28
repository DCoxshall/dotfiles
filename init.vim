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
" Neovide should be used for best experience.

set visualbell
set t_vb=

call plug#begin()
Plug 'nvim-tree/nvim-tree.lua'
Plug 'vim-autoformat/vim-autoformat'
Plug 'Badacadabra/vim-archery'
Plug 'itchyny/lightline.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'master', 'do': ':TSUpdate'} " This line took me ~3 hours to write :P
Plug 'sphamba/smear-cursor.nvim'
call plug#end()

lua require('smear_cursor').enabled = true

" Uncomment all of this for a neat party trick.
" lua require('smear_cursor').setup({
" 			\cursor_color = "#ff4000",
" 			\particles_enabled = true,
" 			\stiffness = 0.5,
" 			\trailing_stiffness = 0.2,
" 			\trailing_exponent = 5,
" 			\damping = 0.6,
" 			\gradient_exponent = 0,
" 			\gamma = 1,
" 			\never_draw_over_target = true,
" 			\hide_target_hack = true,
" 			\particle_spread = 1,
" 			\particles_per_second = 500,
" 			\particles_per_length = 50,
" 			\particle_max_lifetime = 800,
" 			\particle_max_initial_velocity = 20,
" 			\particle_velocity_from_cursor = 0.5,
" 			\particle_damping = 0.15,
" 			\particle_gravity = -50,
" 			\min_distance_emit_particles = 0,
" 			\})

" Treesitter (syntax highlighting)
" Note that Treesitter is broken on Neovim >0.11.3. Should be fixed in 0.12.
" Hopefully.
lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "cpp", "rust", "python" }, -- languages to install
	highlight = {
		enable = true,              -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
		},
}
EOF

" nvim-tree
lua << EOF
require'nvim-tree'.setup {}
EOF

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
inoremap <F3> <Esc>:Autoformat<CR>i

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

" Lightline configuration.
set laststatus=2
set noshowmode
let g:lightline = {'colorscheme': 'wombat'}

" Generic VIM crap.
set relativenumber
set mouse=a
set splitright
set splitbelow
set tabstop=4
set shiftwidth=4
set nowrap

" Neovide settings.
if exists("g:neovide")
	set guifont=Fira\ Code:h10
endif

" NvimTree settings.
noremap <F2> :NvimTreeToggle<CR>
