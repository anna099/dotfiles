" General settings

set nocompatible
set encoding=utf-8
set smartindent
set autoindent
set hidden
set backspace=indent,eol,start
set laststatus=2 " always show statusline
set history=1000
set splitright
set splitbelow
set noerrorbells
set novisualbell
set mouse=nv
set breakindent
set showcmd
set expandtab
set smarttab
set shiftwidth=4
set tabstop=8
set showbreak=∙
set textwidth=80
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.hi,*.DS_Store,*.git/
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
set showmatch
set noswapfile
set termguicolors
syntax on

" Plugins
call plug#begin(stdpath('data') . './plugged')
Plug 'chriskempson/base16-vim'
Plug 'bronson/vim-trailing-whitespace'
call plug#end()

" Colours and highlighting
color base16-one-light
highlight Normal guibg=NONE
highlight StatusLine guifg=#af8787 gui=bold
highlight Comment gui=italic
highlight Search guibg=cornflowerblue guifg=white
highlight markdownItalic gui=italic guifg=grey
highlight markdownBold gui=bold

" Keybindings

nnoremap <space> <nop>
let mapleader=" "

cnoremap <c-a> <home>
cnoremap <c-e> <end>
nnoremap <leader>f gqap
nnoremap <right> <esc>>>
nnoremap <left> <esc><<
nnoremap j gj
nnoremap k gk
nnoremap N 9j
nnoremap M 9k
nnoremap n nzz
nnoremap ; :
vnoremap ; :
nnoremap <leader>a ggVG
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
inoremap ` <esc>
inoremap §` `
vnoremap ` <esc>
nnoremap <leader><cr> :let @/ = ""<cr>
nmap <tab> :bnext<cr>
nmap <s-tab> :bprevious<cr>
nnoremap <leader>Q :bd<cr>
nnoremap Q :q<cr>
nnoremap <backspace> :FixWhitespace<cr>:update<cr>
nnoremap <leader><backspace> :FixWhitespace<cr>:wall<cr>:silent make<cr>
nnoremap <leader>w <c-w>

" Text insertion shortcuts
nnoremap <leader>n yyp<c-a>WC

" The statusline, which is only on the right
set statusline=%="
set statusline+=%t    " filename
set statusline+=%m    " modified?
set statusline+=\ %n  " buffer number
set statusline+=,\ %l " line number

" This is a minimal statusline, with no background:
highlight StatusLine guibg=NONE
highlight StatusLineNC guibg=NONE

nnoremap <leader>u :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>V :edit ~/.config/nvim/init.vim<cr>
