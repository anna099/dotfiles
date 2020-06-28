#!/usr/bin/env bash

# the -i flag warns about overwriting
read -p $'\e[1;96mWould you like to copy over the dotfiles? [y/n] \e[0m' -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp -i .bashrc ~/.bashrc
    cp -i .bash_profile ~/.bash_profile
    cp -i .alacritty.yml ~/.alacritty.yml
    cp -i init.vim ~/.config/nvim/init.vim
    cp -i .inputrc ~/.inputrc
    cp -i .update-dotfiles.sh ~/.update-dotfiles.sh
fi

if ! hash brew 2>/dev/null; then
    read -p $'\e[1;32mWould you like to install Brew? [y/n] \e[0m' -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh
    fi
fi

if hash brew 2>/dev/null; then
    read -p $'\e[1;36mBrew: would you like to install Neovim? [y/n] \e[0m' -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew install neovim

        echo $'\e[36mInstalling vim-plug for Neovim...\e[0m'
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi

    read -p $'\e[1;36mBrew: would you like to install Coreutils? [y/n] \e[0m' -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew install coreutils
    fi

    read -p $'\e[1;36mBrew: would you like to install Bat? [y/n] \e[0m' -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        brew install bat
    fi
fi
