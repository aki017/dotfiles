#!/bin/bash

DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .gdbinit .gitconfig .gitignore .inputrc .screenrc .vimrc .vrapperrc .tmux.conf .dir_colors)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
#    rm $HOME/$file
done

