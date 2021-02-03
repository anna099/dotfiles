" Accessible settings ---------------------------------------------------------
" They are at the top because I'm likely to change them often.

set nowrap
set number
set colorcolumn=+1

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
nnoremap <leader>w <c-w>

cnoremap <c-a> <home>
cnoremap <c-e> <end>
nnoremap <right> <esc>>>
nnoremap <left> <esc><<
vnoremap <right> <esc>>>
vnoremap <left> <esc><<
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
inoremap `` §
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
nnoremap <leader>d gg:put! =strftime('%b %d 20%y')<cr>ILast edited: <esc>
inoremap ;<space><space> ::
iabbrev <expr> day, strftime('%b %d, %Y: %H:%M')
inoremap {<cr> {<cr>}<esc>O
" Solve equation in insert mode:
inoremap <c-f> =<esc>0yt=A<c-r>=<c-r>"<cr><esc>A

" }}}
" The statusline                                                            {{{

function ModeText()
    let l:m = mode()
    if l:m == "c"
        return "Command:"
    endif
    return ""
endfunction

function SpellText()
    if &spell == 1
        return "(S)"
    endif
    return ""
endfunction

set statusline=%{(SpellText())}
set statusline+=\ %{ModeText()}
set statusline+=%="
set statusline+=(%n)  " buffer number
set statusline+=\ %t  " filename
set statusline+=%m    " modified?
set statusline+=,\ %l " line number
set statusline+=/%L   " out of total numbers

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
    " Colour schemes
    Plug 'sainnhe/sonokai'
    Plug 'chriskempson/base16-vim'
call plug#end()

" Plugin-specific bindings:
nnoremap <backspace> :FixWhitespace<cr>:update<cr>
nnoremap <leader>l :Commentary<cr>
nnoremap <leader>q :Files<cr>
nnoremap # :Buffers<cr>
vmap <Enter> <Plug>(EasyAlign)

" A vim-surround shortcut: make a plain paragraph into an HTML <p>aragraph
imap <C-p> <esc>vipJyss<lt>p>gqip$F<lt>i

" }}}
" Colours and highlighting                                                  {{{

" Some things undo custom highlighting, so I wrap these in
" a function which can be called when necessary.
" I won't necessarily have all of these 'turned on' all the time.
function Colors()
    " For keeping a transparent background
    hi Normal      guibg=NONE
    hi NonText     guibg=NONE
    hi EndOfBuffer guibg=NONE
    hi SignColumn  guibg=NONE
    " Basics
    hi StatusLine guibg=bg guifg=#61afef gui=BOLD
    hi Comment gui=italic
    hi LineNr guibg=NONE guifg=#3d3a3e
    hi CursorLineNr guifg=#59b9f5
    " Tabline
    hi Tabline gui=NONE
    hi TablineFill gui=NONE guibg=NONE
    hi TablineSel guibg=#66bbff guifg=#002266
    " HTML and Markdown
    hi markdownCodeBlock guifg=fg
    hi markdownItalic gui=italic
    hi markdownBold gui=bold
    hi htmlItalic gui=italic
    hi htmlBold gui=bold
endfunction

autocmd ColorScheme * call Colors()

set background=dark
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 1
colorscheme sonokai

" }}}
" Custom commands and functions, etc.                                       {{{

command! Build !./build.sh
nnoremap <leader>m :wall<cr>:silent Build<cr>

" Keep the cursorline only in the current window/buffer
augroup CLinCurrent
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

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

" Automatic Markdown list numbering
function! Md_list()
    let l:preceding = getline(line(".") - 1)
    if l:preceding =~ '\v^\d+\.\s.'
        let l:index = matchstr(l:preceding, '\v^\d*')
        call setline(".", l:index + 1. ". ")
    elseif l:preceding =~ '\v^\d+\.\s$'
        call setline(line(".") - 1, "")
    elseif l:preceding[0] == "-" && l:preceding[1] == " "
        if strlen(l:preceding) == 2
            call setline(line(".") - 1, "")
        else
            call setline(".", "- ")
        endif
    endif
endfunction

au FileType markdown inoremap <buffer> <cr> <cr><esc>:call Md_list()<cr>A

" For rustlings
nnoremap <leader>i :g/I AM NOT/d<cr>:let @/ = ""<cr>:w<cr>

" Highlight some common Haskell functions
au FileType haskell syn match Function "show\|elem\|product\|sum"
au FileType haskell syn match Type "Bool\|String\|Int"

" }}}
