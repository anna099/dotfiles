# ------- Prompt --------------------------------------------------------------

grey="\[\033[38;5;243m\]"
red="\[\033[38;5;9m\]"
blue="\[\033[38;5;33m\]"
norm="\[\033[0m\]"

if [ -n "$TMUX" ]; then
    export PS1="$grey$blue\W$grey \$$norm "
else
    export PS1="$grey{$blue\W$grey} \$$norm "
fi

# ------- Preferences ---------------------------------------------------------

export EDITOR="vim"

eval $(dircolors ~/.dircolors)

if [ -t 0 ]; then
    bind 'TAB:menu-complete' # slightly better autocompletion
fi

# ------- Wine Shortcuts ------------------------------------------------------

alias hl2='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Half-Life\ 2/hl2.exe'
alias skyrim='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/R.G.\ Mechanics/Skyrim\ -\ Legendary\ Edition/SkyrimLauncher.exe'

# ------- Aliases & Shortcuts -------------------------------------------------

alias rm='trash'

alias s='sudo'
alias x='exit'
alias c='clear'

alias cat='batcat'
alias lat='batcat --theme=OneHalfLight' # Light cAT
alias mkdir='mkdir -p'
alias ls='ls -F --group-directories-first --color'
alias tree='tree -C'
alias grep='grep -i --color=always'
alias up='cd ..'

alias pac='sudo apt install'
alias open='xdg-open'

# vim shortcuts
alias vim='nvim'
alias vi='nvim'
alias v='vim -c "normal '\''0"' # open most recent file

# fzf shortcuts
alias fim='vim $(fzf --reverse --height=10%)' # requires fzf
alias fiff='git diff $(fzf --reverse --height=10%)'

# markdown search
ms() { grep $1 */*.md; }

mkd() { mkdir $1 && cd $1; }
get() { git clone https://github.com/$1; }

p() { cd ~/.programs/$1; }
d() { cd ~/Documents/$1; }
n() { cd ~/Notes; }
N() { ~/Notes/build.sh && open ~/Notes/out/notes.pdf; }

define() { cambrinary -w $1; }

# git shortcuts
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'
alias gpoa='git push origin main'
alias md='git status -s */*.md'

# rust shortcuts
alias re='vim src/main.rs'
alias rr='cargo run'

config() {
    if [ $1 = "b" ]; then
        vim ~/.bashrc && source ~/.bashrc
    elif [ $1 = "v" ]; then
        vim ~/.config/nvim/init.vim
    elif [ $1 = "a" ]; then
        vim ~/.alacritty.yml
    elif [ $1 = "t" ]; then
        vim ~/.tmux.conf
    else
        echo "Config file not recognised."
    fi
}
