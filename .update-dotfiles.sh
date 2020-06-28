#!/usr/bin/env bash

if [ ! -d "~/.dotfiles" ]; then
    mkdir -p ~/.dotfiles
fi

cp ~/.config/nvim/init.vim ~/.dotfiles/init.vim
cp ~/.bashrc ~/.dotfiles/.bashrc
cp ~/.bash_profile ~/.dotfiles/.bash_profile
cp ~/.alacritty.yml ~/.dotfiles/.alacritty.yml
cp ~/.tmux.conf ~/.dotfiles/.tmux.conf
