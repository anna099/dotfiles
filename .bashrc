export PS1="\[\033[38;5;8m\]\W\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;88m\];\[$(tput sgr0)\] \[$(tput sgr0)\]"

alias vim='nvim'
alias vi='nvim'
alias mkdir='mkdir -p'
alias up='cd ..'

if hash bat 2>/dev/null; then
    alias cat='bat --theme=base16'
fi

if hash gls 2>/dev/null; then
    alias ls='gls -AF --group-directories-first --color'
fi

alias xa='killall alacritty'

get() {
    git clone https://github.com/$1
}
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'

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
