" ----- Plugins -----
call plug#begin('~/.vim/plugged')
Plug 'bronson/vim-trailing-whitespace'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'chriskempson/base16-vim'
Plug 'haya14busa/incsearch.vim'
Plug 'kana/vim-niceblock'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovimhaskell/haskell-vim'
Plug 'psliwka/vim-smoothie'
Plug 'rbong/vim-crystalline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

" ----- Plugin configuration: -----
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

" ----- Settings I am likely to change now and then: -----
set number
set nowrap
set cc=80
set nocul
set scrolloff=5

" ----- Basic configuration: -----
set encoding=utf-8
set smartindent
set autoindent
set hidden " Don't close buffers when they're abandoned
set backspace=indent,eol,start
set laststatus=1 " Show status line only when there's multiple windows
set history=1000
set splitright
set splitbelow
set noerrorbells
set novisualbell
set mouse=nv " Allow the mouse to work in normal and visual mode
set breakindent " If a line is wrapped, indent the wrapped part
set showcmd " Show the current command in the bototm right
set expandtab
set smarttab
set shiftwidth=4
set tabstop=8
set showbreak=∙ " Use this char to indicate a wrapped line
set textwidth=80 " Break at this point (if breaking enabled)
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.hi,*.DS_Store,*.git/
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
set showmatch
let loaded_matchparen = 0
set noswapfile
set termguicolors
au VimResized * :wincmd = " Match size to size of terminal window

" ----- Use Space as Leader -----
nnoremap <space> <nop>
let mapleader=" "

" ----- Key Bindings: -----
cnoremap <c-a> <home>
cnoremap <c-e> <end>

inoremap ` <esc>
inoremap §` `
vnoremap ` <esc>

" For manipulating text: -----
nnoremap <leader>f vipJgqq
nnoremap <right> <esc>>>
nnoremap <left>  <esc><<
vnoremap <right> >>
vnoremap <left>  <<
nnoremap <up>    <esc>ddkP
nnoremap <down>  <esc>ddp
nnoremap Y y$

" For moving around, etc.: -----
nnoremap j gj
nnoremap k gk
nnoremap N 9j
nnoremap M 9k
vnoremap N 9j
vnoremap M 9k
if exists("g:smoothie_base_speed") " Give smooth animation if I have the plugin
    nnoremap N :<C-U>call smoothie#downwards() <CR>
    nnoremap M :<C-U>call smoothie#upwards()   <CR>
    vnoremap N :<C-U>call smoothie#downwards() <CR>
    vnoremap M :<C-U>call smoothie#upwards()   <CR>
endif
nnoremap n nzz
nnoremap <leader><cr> :let @/ = ""<cr>
nnoremap ; :
vnoremap ; :
nnoremap <leader>a ggVG
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" For managing windows, buffers, and files: -----
nmap <tab> :bnext<cr>
nmap <s-tab> :bprevious<cr>
nnoremap <leader>q :bd<cr>
nnoremap Q :q<cr>
nnoremap <backspace> :FixWhitespace<cr>:update<cr>
nnoremap s <c-w>
nnoremap <leader>ev :e ~/.vimrc<cr>
nnoremap <leader>v :sp ~/.vimrc<cr>
cnoreabbrev H vert h

" Insert-Mode bindings: -----
inoremap <up>    <esc>ddkPi
inoremap <down>  <esc>ddpi

" ----- Colourschemes and Appearance -----
colo base16-solarized-dark
hi Normal guibg=0
hi LineNr guibg=bg guifg=#444444

hi htmlItalic cterm=italic
hi htmlBold   cterm=bold

" ----- Filetype-specific Settings -----
au BufEnter *.html inoremap -- &mdash;
au BufEnter *.html inoremap [i <i>
au BufEnter *.html inoremap ]i </i>
au BufEnter *.html inoremap [b <b>
au BufEnter *.html inoremap ]b </b>

" ----- Status line -----
"    " Left hand side
"    set statusline=(\ %f\ ) " Filepath
"    set statusline+=\ %y    " Language
"    set statusline+=\ %n    " Buffer number
"    set statusline+=%M      " Modified?
"    set statusline+=%="
"    " Right hand side
"    set statusline+=\ %l    " Line number
"    set statusline+=\ of
"    set statusline+=\ %L    " Line count
"    set statusline+=\ %r    " Readonly?

function! StatusLine(current)
  return a:current ?
        \ crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
        \ . crystalline#left_sep('', 'Fill') . ' %{&ft} %l/%L'
        \ : ''
endfunction
let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'solarized'
set laststatus=2

set tabline=%!crystalline#bufferline()
set showtabline=2

" ----- 'Space + u' will reload this file ----
nnoremap <leader>u :source ~/.vimrc<cr>
