 "Plugins

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw)
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/tpope/vim-unimpaired' " For inserting new lines before or after current and other misc.
Plug 'https://github.com/preservim/nerdtree' ", {'on': 'NERDTreeToggle'}
Plug 'https://github.com/navarasu/onedark.nvim'
Plug 'https://github.com/catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar', {'on': 'TagbarToggle'} " Tagbar for code navigation

" Fuzzy Finder, Needs Silversearcher-ag for :Ag
Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'https://github.com/vim-test/vim-test'
Plug 'https://github.com/preservim/vimux'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-repeat' " enable repeating supported plugin maps with .
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/csexton/trailertrash.vim'
Plug 'https://github.com/nvie/vim-flake8' " Also install flake8 via pip

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

set cursorline
set colorcolumn=80

nnoremap <M-;> ,
xnoremap <M-;> ,
onoremap <M-;> ,

let mapleader = "," " map leader to comma

" To hide highlighting after a search.
nmap <leader>h :noh<CR>
nmap <leader>f :FZF<cr>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" VIM-COMMENTARY
autocmd FileType cpp setlocal commentstring=//\ %s

" let g:onedark_config = {
"     \ 'style': 'warmer',
" \}
" " :colorscheme base16-onedark
" :colorscheme onedark

" :colorscheme gruvbox

colorscheme catppuccin-mocha " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

" NERDTree Configuration
nnoremap <C-n> :NERDTreeToggle<CR>


" VIM AIRLINE CONFIGURATION

let g:airline_powerline_fonts = 1
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text'
    \]

let g:airline_theme='powerlineish'
" let g:airline_theme='gruvbox'


" Tagbar

nmap <F6> :TagbarToggle<CR>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Note -> Use CocList diagnostics to get all linter errors, Note -> .vim
" folder is created for every project where linter is specified

inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<C-H>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let test#strategy = "vimux"

" Select whole file
nmap <leader>, ggVG

if has('python')
  map <C-K> :pyf /usr/share/clang/clang-format-18/clang-format.py<cr>
elseif has('python3')
  map <C-K> :py3f /usr/share/clang/clang-format-18/clang-format.py<cr>
endif

" Trim trailing whitespace
nmap <silent> <leader><SPACE> :TrailerTrim<CR>

autocmd FileType c nnoremap <buffer> <leader>F A<CR>{<CR>}<Esc>O
autocmd FileType cpp nnoremap <buffer> <leader>F A<CR>{<CR>}<Esc>O

