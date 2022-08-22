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
set guicursor=n-v:block,i:ver10,r:hor10,c-ci:ver10
set diffopt+=vertical
set nojoinspaces
set scrolloff=1
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<
set confirm " ask to save when quitting an edited file
set title

" }}}
" Folds                                                                     {{{
set foldmethod=marker
function! MyFoldText() " Steve Losh's, with Modifications
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount) - 1
    return line . ' ↴ ' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()
" }}}
" Keybindings                                                               {{{
nnoremap <up> <nop>

nnoremap <down> <nop>

nnoremap <space> <nop>
let mapleader=" "

nnoremap <leader>b :Nuake<cr>
nnoremap <leader>f gqap
nnoremap <leader>a ggVG
nnoremap <leader>m :wall<cr>:silent !./build.sh %<cr>
nnoremap <leader>o za
nnoremap <leader>u :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>v :sp ~/.config/nvim/init.vim<cr>
nnoremap <leader>V :edit ~/.config/nvim/init.vim<cr>
nnoremap <leader>? :set spell!<cr>
nnoremap <leader><cr> :nohlsearch<cr>
nnoremap <leader>] :set number!<cr>

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
nnoremap < ,
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
nnoremap ci_ T_ct_

" Show current highlighting group
nnoremap <F8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Text-insertion bindings
nnoremap <leader>n yyp<c-a>WC
iabbrev <expr> day, strftime('%b %d, %Y: %H:%M')
inoremap ;; ::
inoremap {<cr> {<cr>}<esc>O
inoremap `` §
inoremap <c-c> <!--  --><esc>bhi
" Solve equation in insert mode:
inoremap <c-f> =<esc>0yt=A<c-r>=<c-r>"<cr><esc>A

" }}}
" The statusline                                                            {{{

function SpellText() abort
    if &spell == 1
        return " (Sp)"
    endif
    return ""
endfunction

function BufNumText() abort
    return "%n/" . len(getbufinfo({'buflisted':1}))
endfunction

let g:modenames={
    \ 'n'  : 'normal',
    \ 'no' : 'pending',
    \ 'v'  : 'visual',
    \ 'V'  : 'v-line',
    \ 'CTRL-V' : 'v-block',
    \ 'i'  : 'insert',
    \ 'R'  : 'replace',
    \ 'c'  : 'command',
    \ 'r'  : 'prompt',
    \}
function ModeText() abort
    return toupper(get(g:modenames, mode(), '...'))
endfunction

function MyStatusLine() abort
    let sl = ""

    if g:statusline_winid == win_getid(winnr())
        " Active window:

        " '%N*', where N is an integer, means that the text
        " is highlighted according to the group UserN. See the
        " 'Colours and highlighting' section below. '%*'
        " reverts the highlighting to the default.

        let sl .= "%1*  %t%*"                         " filename (colour 1)
        let sl .= "%2* %m %*"                         " modified? (colour 2)
        let sl .= SpellText()                         " spellcheck on?
        let sl .= " (" . BufNumText() . ")"           " buffer number / total
        let sl .= "%*%="                              " align right
        let sl .= " %3* %l%*"                          " line number (colour 3)
        let sl .= "%4*:%c"                            " column number
        let sl .= "/%L %*"                            " out of total numbers
        let sl .= "%5* " . ModeText() . " "           " current mode
    else
        " Inactive window:
        let sl = "(%t) %m"                         " filename + modified?
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
    Plug 'cespare/vim-toml'
    Plug 'justinmk/vim-sneak'
    Plug 'rust-lang/rust.vim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'ackyshake/VimCompletesMe'
    Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
    " Colour schemes
    Plug 'sainnhe/sonokai'
    Plug 'lifepillar/vim-gruvbox8'
    Plug 'rakr/vim-one'
    Plug 'folke/tokyonight.nvim'
    Plug 'tanvirtin/monokai.nvim'
    Plug 'ayu-theme/ayu-vim'
call plug#end()

" Plugin-specific bindings:
nnoremap <backspace> :FixWhitespace<cr>:update<cr>
nnoremap <leader>l :Commentary<cr>
nnoremap # :Clap buffers<cr>
nnoremap <leader>q :Clap files<cr>

" }}}
" Colours and Appearance                                                    {{{

function CustomColors()
    hi Normal guibg=none
    hi NonText guibg=none
    hi SignColumn guibg=none
    hi VertSplit guibg=none
    hi Comment gui=italic
    " Just highlight the line # for cursorline:
        " hi CursorLine guibg=bg
        " hi CursorLineNr guibg=bg
    " Markdown and HTML:
    hi markdownItalic gui=italic
    hi markdownBold gui=bold
    hi htmlItalic gui=italic
    hi htmlBold gui=bold
endfunction

function StatusColors()
    " User1 : filename.
    " User2 : [+] to indicate file changes.
    " User3 : current line.
    " User4 : total line numbers.
    " User5 : mode name.
    " Note: 'hi StatusLine' needs 'gui=none' or otherwise it is
    "       inverted by default.
    hi StatusLine        gui=none   guifg=#445d70 guibg=#111111
    hi StatusLineNC                 guifg=#445d70
    hi User1             gui=bold   guifg=white   guibg=#234066
    hi User2             gui=bold   guifg=lime    guibg=#234066
    hi User3             gui=bold   guifg=#40c795 guibg=#333333
    hi User4                        guifg=white   guibg=#333333
    hi User5             gui=bold   guifg=white   guibg=#008643
    if &background == "light"
        hi LineNr       guifg=#cccccc
        hi StatusLine   guifg=#333333 guibg=#eeeeee
        hi StatusLineNC guifg=#eeeeee guibg=#aaaaaa
        hi User3        guifg=#008795 guibg=#faeaaa
        hi User4        guifg=grey    guibg=#faeaaa
    endif
endfunction

autocmd ColorScheme * call CustomColors()
autocmd ColorScheme * call StatusColors()

set guifont=Iosevka:h12

" }}}
" Custom commands and functions, etc.                                       {{{

" Open help page in a vertical split instead of a horizontal one
command! -nargs=1 H vsp|help <args>|normal <c-w>k:q<cr>

" Keep the cursorline only in the current window/buffer
" if &cursorline
"     augroup CLinCurrent
"         au!
"         au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"         au WinLeave * setlocal nocursorline
"     augroup END
" endif

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
" nnoremap <leader><leader> :call Seal()<cr>

" }}}

set background=light
let ayucolor="light"
colorscheme one
hi Normal guifg=#000000
hi markdownItalic guifg=#0033bb
hi VertSplit guifg=lightpink
