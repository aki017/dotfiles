#!/bin/bash

 VIM_FILES=( .vimrc )
 TMUX_FILES=( .tmux.conf .tmux-powerlinerc )
 ZSH_FILES=( .zshrc )
 OTHER_FILES=( .gdbinit .gitconfig .gitignore .inputrc .screenrc .dir_colors)
 DOT_FILES=( "${VIM_FILES[@]}" "${TMUX_FILES[@]}" "${ZSH_FILES[@]}" "${OTHER_FILES[@]}" )

for file in ${DOT_FILES[@]}
do
    if [ -e $HOME/$file ]; then
        mv $HOME/$file $HOME/$file.old
    #    rm $HOME/$file
    fi
    ln -s $HOME/dotfiles/$file $HOME/$file
done

git submodule update --init
mkdir -p ~/.neobundle
cd ~/.neobundle
git clone https://github.com/Shougo/neobundle.vim.git
vim -s viminit
touch ~/.z
touch ~/.cdd

