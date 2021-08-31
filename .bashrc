grey="\[\033[38;5;243m\]"
red="\[\033[38;5;9m\]"
blue="\[\033[38;5;33m\]"
pink="\[\033[38;5;175m\]"
norm="\[\033[0m\]"

# reset cursor formatting to avoid weird glitches
rc() {
  printf '\[\033]50;CursorShape=1\x7\]'
}

# ------- Tmux welcome message ------------------------------------------------

if [ -n "$TMUX" ]; then
    neofetch
fi

# ------- Preferences ---------------------------------------------------------

export EDITOR="vim"

eval $(dircolors ~/.dircolors)

if [ -t 0 ]; then
    bind 'TAB:menu-complete' # slightly better autocompletion
fi

# ------- Aliases & Shortcuts -------------------------------------------------

alias n='vim ~/notes.md && pandoc ~/notes.md --css=.notes.css --metadata pagetitle="Notes" -s -o ~/.notes.html'

alias rm='trash'

alias s='sudo'
alias x='exit'
alias c='clear'

alias cat='batcat --theme=OneHalfLight'
alias dat='batcat --theme=OneHalfDark'
alias mkdir='mkdir -p'
alias ls='ls -F --group-directories-first --color'
alias tree='tree -C'
alias up='cd ..'

alias pac='sudo apt install'
alias open='xdg-open'

# vim shortcuts
alias vim='nvim'
alias vi='nvim'
alias v='vim -c "normal '\''0"' # open most recent file

# grep -> ripgrep
alias grep='rg -S'
alias ms='rg -S -t md'

mkd() { mkdir $1 && cd $1; }
get() { git clone https://github.com/$1; }

p() { cd ~/.programs/$1; }
d() { cd ~/Documents/$1; }

define() { cambrinary -w $1; }

# git shortcuts
alias gpom='git push origin master'
alias gpog='git push origin gh-pages'
alias gpoa='git push origin main'
alias md='git status -s */*.md'

# rust shortcuts
alias re='vim src/main.rs'
alias rr='cargo run'
alias rrr='cargo run --release'

config() {
    if [ $1 = "b" ]; then
        vim ~/.bashrc && source ~/.bashrc
    elif [ $1 = "v" ]; then
        vim ~/.config/nvim/init.vim
    elif [ $1 = "a" ]; then
        vim ~/.alacritty.yml
    elif [ $1 = "t" ]; then
        vim ~/.tmux.conf
    elif [ $1 = "w" ]; then
        vim ~/.wezterm.lua
    else
        echo "Config file not recognised."
    fi
}

# ------- Wine Shortcuts ------------------------------------------------------

alias hl2='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Half-Life\ 2/hl2.exe'
alias skyrim='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/R.G.\ Mechanics/Skyrim\ -\ Legendary\ Edition/SkyrimLauncher.exe'

# ------- FZF Fuzzy Finder ----------------------------------------------------

alias fim='vim $(fzf --reverse --height=10%)' # requires fzf
alias fiff='git diff $(fzf --reverse --height=10%)'

# ------- Colour Scheme Switcher ----------------------------------------------

colour() { # argument must be 'dark' or 'light'
    alacritty_config=~/.alacritty.yml
    sed -i"" "s/\(^colors: \*\).*/\1$1/g" $alacritty_config

    vim_config=~/.config/nvim/init.vim
    sed -i"" "s/\(^let dark_mode = \).*/\1$1/g" $vim_config

    if [ $1 = "dark" ]; then
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
            --color info:150,prompt:110,spinner:150,pointer:167,marker:174'
    else
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
            --color=fg:#3c3836,bg:#fffefa,hl:#4eb51f
            --color=fg+:#3c3836,bg+:#fcf9ea,hl+:#ff2185
            --color=info:#afaf87,prompt:#5f87af,pointer:#cc241d
            --color=marker:#d79921,spinner:#8f3f71,header:#076678'
    fi
}

# ------- Prompt --------------------------------------------------------------

# prompt char, e.g. ➜, λ or $
pc='λ'

my_prompt() {
    if [ -d .git ]; then
        if [[ $(git status --porcelain || wc -l) ]]; then
            export PS1="$(rc)$grey$blue\W $red* $(mtodo count short) $grey$pc$norm "
        else
            export PS1="$(rc)$grey$blue\W$grey $pc$norm "
        fi
    else
        if [ -n "$TMUX" ]; then
            export PS1="$(rc)$grey$blue\W$grey $pc$norm "
        else
            export PS1="$(rc)$grey($blue\W$grey) $pc$norm "

        fi
    fi
}

PROMPT_COMMAND="my_prompt"
