" Type 261G to change the color scheme.
"
" Accessible settings ---------------------------------------------------------
" They are at the top because I'm likely to change them often.

set nowrap
set nonumber
set colorcolumn=+1
set list
set nocursorline

" General settings                                                          {{{
set nocompatible
syntax on
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
set mouse=n
set breakindent
set showcmd
set expandtab
set smarttab
set shiftwidth=4
set tabstop=8
set showbreak=∙
set textwidth=80
set wildmenu
set wildignore=*.o,*.hi,*.DS_Store,*.git/,Cargo.lock
set wildignorecase
set ignorecase
set smartcase
set infercase
set hlsearch
set incsearch
set gdefault
set showmatch
set noswapfile
set termguicolors
set conceallevel=2
set concealcursor=""
set foldmethod=marker
set guicursor=n-v:block,i:ver10,r:hor10,c-ci:ver10
set diffopt+=vertical
set nojoinspaces
set scrolloff=4
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<

" }}}
" Keybindings                                                               {{{

nnoremap <space> <nop>
let mapleader=" "

nnoremap <leader>f gqap
nnoremap <leader>a ggVG
nnoremap <leader><cr> :nohlsearch<cr>
nnoremap <leader>o za
nnoremap <leader>u :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>V :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>? :set spell!<cr>

" Moving between splits:
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

cnoremap <c-a> <home>
cnoremap <c-e> <end>
nnoremap <right> <esc>>>
nnoremap <left> <esc><<
vnoremap <right> >gv
vnoremap <left> <gv
nnoremap j gj
nnoremap k gk
nnoremap n nzz
nnoremap ; :
vnoremap ; :
nnoremap , ;
nnoremap Y y$
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
nnoremap } }j
nnoremap { {k
nmap <tab> :bnext<cr>
nmap <s-tab> :bprevious<cr>
nnoremap Q :q<cr>

" Show current highlighting group
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Text-insertion bindings
nnoremap <leader>n yyp<c-a>WC
nmap <leader>d gg:put! =strftime('%b %d 20%y')<cr>ILast edited: <esc>:Commentary<cr>
iabbrev <expr> day, strftime('%b %d, %Y: %H:%M')
inoremap {<cr> {<cr>}<esc>O
inoremap `` §
" Solve equation in insert mode:
inoremap <c-f> =<esc>0yt=A<c-r>=<c-r>"<cr><esc>A

" }}}
" The statusline                                                            {{{

function SpellText()
    if &spell == 1
        return " (Sp)"
    endif
    return ""
endfunction

function BufNumText()
    return "%n/" . len(getbufinfo({'buflisted':1}))
endfunction

function MyStatusLine() abort
    let sl = ""

    if g:statusline_winid == win_getid(winnr())
        " Active window:

        " '%N*', where N is an integer, means that the text
        " is highlighted according to the group UserN. See the
        " 'Colours and highlighting' section below. '%*'
        " reverts the highlighting to the default.

        let sl .= "%1* %t %*"                    " filename (colour 1)
        let sl .= SpellText()                    " spellcheck on?
        let sl .= " (" . BufNumText() . ")"      " buffer number / total
        let sl .= "%*%="                         " align right
        let sl .= "%2*%m%*"                      " modified? (colour 2)
        let sl .= " %3*%l%*"                     " line number (colour 3)
        let sl .= ":%c"                          " column number
        let sl .= "/%L"                          " out of total numbers
    else
        " Inactive window:
        let sl = "%t %m"                         " filename + modified?
    endif

    return sl
endfunction

set statusline=%!MyStatusLine()

" }}}
" Plugins                                                                   {{{

call plug#begin(stdpath('data') . '/plugged')
    Plug 'bronson/vim-trailing-whitespace'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'ervandew/supertab'
    Plug 'cespare/vim-toml'
    Plug 'prettier/vim-prettier'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'junegunn/vim-easy-align'
    Plug 'neovimhaskell/haskell-vim'
    Plug 'rust-lang/rust.vim'
    Plug 'michaeljsmith/vim-indent-object'
    " Colour schemes
    Plug 'chriskempson/base16-vim'
    Plug 'sainnhe/sonokai'
call plug#end()

" Plugin-specific bindings:
nnoremap <backspace> :FixWhitespace<cr>:update<cr>
nnoremap <leader>l :Commentary<cr>
nnoremap <leader>q :Files<cr>
nnoremap # :Buffers<cr>
vmap <Enter> <Plug>(EasyAlign)

" For plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1

" A vim-surround shortcut: make a plain paragraph into an HTML <p>aragraph
imap <C-p> <esc>vipJyss<lt>p>gqip$F<lt>i

" }}}
" Colours and highlighting                                                  {{{

" Some things undo custom highlighting, so I wrap my customisations
" in a few functions.
function ColorsCore()
    "  NAME              STYLE      FOREGROUND    BACKGROUND
    hi Normal                                     guibg=none
    hi NonText                                    guibg=none
    hi EndOfBuffer                                guibg=none
    hi SignColumn                                 guibg=none
    hi StatusLine        gui=bold   guifg=#616161 guibg=bg
    hi StatusLineNC      gui=none   guifg=#445d70 guibg=bg
    hi Comment           gui=italic
    hi Function          gui=italic
    hi CursorLineNr                 guifg=#9d9a9e
    hi VertSplit                    guifg=#585858 guibg=none
    hi CursorLineNr                 guifg=#59b9f5
    hi LineNr                       guifg=#3d3a3e guibg=none
endfunction

function ColorsMdHtml()
    "  NAME              STYLE      FOREGROUND    BACKGROUND
    hi mkdFootnotes      gui=bold   guifg=hotpink
    hi mkdBlockquote     gui=italic guifg=#ffffdd
    hi markdownCodeBlock            guifg=fg
    hi markdownItalic    gui=italic
    hi markdownBold      gui=bold
    hi htmlItalic        gui=italic
    hi htmlBold          gui=bold
endfunction

function ColorsStatus()
    "  NAME              STYLE      FOREGROUND    BACKGROUND
    hi User1             gui=bold   guifg=#66D9EF
    hi User2                        guifg=hotpink
    hi User3             gui=italic guifg=#40c795
endfunction

autocmd ColorScheme * call ColorsCore()
autocmd ColorScheme * call ColorsMdHtml()
autocmd ColorScheme * call ColorsStatus()

let g:sonokai_style = 'espresso'
let g:sonokai_enable_italic = 1

set background=dark
colorscheme sonokai

" }}}
" Custom commands and functions, etc.                                       {{{

command! Build !./build.sh %
nnoremap <leader>m :wall<cr>:silent Build<cr>

" Keep the cursorline only in the current window/buffer
" augroup CLinCurrent
"     au!
"     au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"     au WinLeave * setlocal nocursorline
" augroup END

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

" }}}
" Filetype-specific                                                         {{{

" For rustlings
nnoremap <leader>i :g/I AM NOT/d<cr>:let @/ = ""<cr>:w<cr>

" }}}
