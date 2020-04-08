alias t='node index.js hume'

export PATH="~/.local/bin:~/Library/Haskell/bin:$PATH"

shopt -s nocaseglob # ignore case in autocomplete
shopt -s cdspell # autocorrection in `cd` arguments

alias vim=nvim
alias vi=nvim

# shortcut to reopen last file in vim
alias v="vim -c \"normal '0\""

# use python3
alias py=python3

# utliity shortcuts
alias up='cd ..'
alias cp='cp -iv' # interactive and verbose `cp`
alias mv='mv -iv' # interactive and verbose `mv`
alias mkdir='mkdir -p' # create intermediate directories
alias grep='egrep -i --colour=always'  # -i = insensitive.
alias GREP='egrep -Hn --colour=always' # -H = show filename, -n = show line number
alias ls='colorls -At'

alias p='cd ~/.programs'
alias h='cd ~/.haskell'
alias ph='cd ~/.programs/haskell'
alias k='cd ~/.programs/kant && imgcat kant.jpg'

# git shortcuts
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'
get() { git clone https://github.com/$1; }
getmy() { git clone https://github.com/anna099/$1; }

#export PS1="  \[\033[38;5;6m\]\W\[$(tput sgr0)\]: "
export PS1=" \[\033[38;5;39m\]\W\[$(tput sgr0)\]\[\033[38;5;159m\]>\[$(tput sgr0)\] \[$(tput sgr0)\]"

function ghc-pkg-reset() {
    read -p 'erasing all your user ghc and cabal packages - are you sure (y/n) ? ' ans
    test x$ans == xy && ( \
        echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`; \
        echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib; \
        # echo 'erasing ~/.cabal/packages'; rm -rf ~/.cabal/packages; \                                                                                                                                                                     
        # echo 'erasing ~/.cabal/share'; rm -rf ~/.cabal/share; \                                                                                                                                                                           
        )
}

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
