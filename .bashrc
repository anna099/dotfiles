# Aliases and functions {{{
# General purpose
alias c='clear'
alias s='sudo'
alias x='exit'
alias ls='ls -F --group-directories-first --color'
alias up='cd ..'
alias rm='trash-put'
# Applications
alias vim='nvim'
alias vi='nvim'
alias v='vim -c "normal '\''0"'
alias open='xdg-open'
# Rust related
alias re='vim src/main.rs'
alias rr='cargo run'
# Pacman
alias pac='sudo pacman -S'
alias autoremove='pacman -Qdtq | sudo pacman -Rs -'
# Folder shortcuts
p() { cd ~/.programs/$1; }
# Git related
alias md='git status -s */*.md'
alias gpog='git push origin gh-pages'
get() { git clone https://github.com/$1; }
# }}}
# The `config` function {{{
config() {
    if [ $1 = "b" ]; then
        vim ~/.bashrc && source ~/.bashrc
    elif [ $1 = "v" ]; then
        vim ~/.config/nvim/init.vim
    elif [ $1 = "a" ]; then
        vim ~/.alacritty.yml
    elif [ $1 = "t" ]; then
        vim ~/.tmux.conf
    elif [ $1 = "c" ]; then
        vim ~/.config/conky/conky.conf
    else
        echo "Config file not recognised."
    fi
}
# }}}
# Prompt {{{
rc() { printf '\[\033]50;CursorShape=1\x7\]'; } # reset cursor
grey="\[\033[38;5;243m\]"
colour="\[\033[38;5;122m\]"
normal="\[\033[0m\]"
export PS1="$(rc)$grey<$colour\W$grey> $normal"
# }}}
# Extras {{{
. "$HOME/.cargo/env" # enable rust
# }}}
# Variables {{{
export PATH=$PATH:/home/anna/.programs/bin
# }}}
