" Accessible settings ---------------------------------------------------------
" They are at the top because I'm likely to change them often.

set nowrap
set cursorline

" General settings ------------------------------------------------------------

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

" Plugins ---------------------------------------------------------------------

call plug#begin(stdpath('data') . './plugged')
Plug 'chriskempson/base16-vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/Goyo.vim'
Plug 'Yggdroot/indentLine'
Plug 'neovimhaskell/haskell-vim'
call plug#end()

autocmd! User GoyoLeave nested call Colors()
let g:indentLine_char = '┊'

" Colours and highlighting ----------------------------------------------------

color base16-onedark

" Some things undo custom highlighting, so I wrap these in
" a function which can be called when necessary.
function Colors()
    hi Normal guibg=NONE
    hi StatusLine guifg=#af8787 gui=bold guibg=NONE
    hi StatusLineNC guibg=NONE
    hi VertSplit guibg=NONE
    hi Comment gui=italic
    hi Search guibg=cornflowerblue guifg=white
    hi markdownItalic gui=italic
    hi markdownBold gui=bold
endfunction
call Colors()

" Keybindings -----------------------------------------------------------------

nnoremap <space> <nop>
let mapleader=" "

cnoremap <c-a> <home>
cnoremap <c-e> <end>
nnoremap <leader>f gqap
nnoremap <right> <esc>>>
nnoremap <left> <esc><<
vnoremap <right> <esc>>>
vnoremap <left> <esc><<
nnoremap j gj
nnoremap k gk
nnoremap N 9j
nnoremap M 9k
vnoremap N 9j
vnoremap M 9k
nnoremap n nzz
nnoremap ; :
vnoremap ; :
nnoremap <leader>a ggVG
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
inoremap `` §
nnoremap <leader><cr> :let @/ = ""<cr>
nmap <tab> :bnext<cr>
nmap <s-tab> :bprevious<cr>
nnoremap <leader>Q :bd<cr>
nnoremap Q :q<cr>
nnoremap <leader>w <c-w>

" Plugin-specific bindings:
nnoremap <backspace> :FixWhitespace<cr>:update<cr>
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>l :Commentary<cr>

" Text-insertion bindings
nnoremap <leader>n yyp<c-a>WC
inoremap ;; ::
iabbrev <expr> day, strftime('%y %b %d')
nnoremap <leader>d gg:put! =strftime('%y %b %d')<cr>ILast edited: <esc>

" Custom commands and functions, etc. -----------------------------------------

command! Build !./build.sh
nnoremap <leader>m :wall<cr>:silent Build<cr>

function Seal()
    if winline() == winheight(winnr()) / 2 ||
    \  winline() == (winheight(winnr()) / 2) + 1 " (For odd-numbered heights)
        normal! zt
    elseif winline() == 1
        normal! zb
    else
        normal! zz
    endif
endfunction
nnoremap <leader><leader> :call Seal()<cr>

" The statusline --------------------------------------------------------------

set statusline=%="
set statusline+=%t    " filename
set statusline+=%m    " modified?
set statusline+=\ %n  " buffer number
set statusline+=,\ %l " line number
set statusline+=/%L   " out of total numbers

nnoremap <leader>u :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>V :edit ~/.config/nvim/init.vim<cr>
