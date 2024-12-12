 "Plugins

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/preservim/nerdtree' ", {'on': 'NERDTreeToggle'}
Plug 'https://github.com/navarasu/onedark.nvim'
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar', {'on': 'TagbarToggle'} " Tagbar for code navigation

call plug#end()

filetype plugin indent on

set number
set relativenumber
set mouse=a

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set encoding=UTF-8
set visualbell

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

let g:onedark_config = {
    \ 'style': 'warmer',
\}
" :colorscheme base16-onedark
:colorscheme onedark

" :colorscheme gruvbox

" NERDTree Configuration
nnoremap <C-n> :NERDTreeToggle<CR>


" VIM AIRLINE CONFIGURATION

let g:airline_powerline_fonts = 1
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text'
    \]

let g:airline_theme='onedark'
" let g:airline_theme='gruvbox'


" Tagbar

nmap <F6> :TagbarToggle<CR>

