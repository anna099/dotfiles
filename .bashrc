# ------- Prompt --------------------------------------------------------------

grey="\[\033[38;5;243m\]"
pink="\[\033[38;5;9m\]"
norm="\[\033[0m\]"

if [ -n "$TMUX" ]; then
    export PS1="$grey($pink\W$grey) $norm"
else
    export PS1="$grey{$pink\W$grey} $norm"
fi

# ------- Preferences ---------------------------------------------------------

export EDITOR="vim"

eval $(dircolors ~/.dircolors)

bind 'TAB:menu-complete' # slightly better autocompletion

# ------- Aliases & Shortcuts -------------------------------------------------

alias cat='batcat'
alias vim='nvim'
alias vi='nvim'
alias mkdir='mkdir -p'
alias ls='ls -F --group-directories-first --color'
alias tree='tree -C'
alias grep='grep -i --color=always'

alias up='cd ..'
alias x='exit'

alias pac='sudo apt install'
alias open='xdg-open'


mkd() { mkdir $1 && cd $1; }
get() { git clone https://github.com/$1; }
fim() { vim -c Files; } # requires fzf

p() { cd ~/.programs/$1; }
d() { cd ~/Documents/$1; }
n() { cd ~/Notes; }
N() { ~/Notes/build.sh && open ~/Notes/out/notes.pdf; }

# git shortcuts
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'
alias md='git status -s */*.md'

# rust shortcuts
alias Re='vim src/main.rs'
alias Rr='cargo run'

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
