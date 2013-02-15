#!/bin/bash

 DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .gdbinit .gitconfig .gitignore .inputrc .screenrc .vimrc .vrapperrc .tmux.conf .tmux-powerlinerc .dir_colors)

for file in ${DOT_FILES[@]}
do
    rm    $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
    mkdir -p ~/.vim/bundle
    cd ~/.vim/bundle
    git clone https://github.com/gmarik/vundle.git 
    touch ~/.z
    touch ~/.cdd
#    rm $HOME/$file
done

