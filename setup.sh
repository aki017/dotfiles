#!/bin/bash


function safe_ln() {
    if [ -e $2 ]; then
        mv $2 $2.old
    fi
    ln -s $1 $2
}

function ln_dot() {
    safe_ln "$HOME/dotfiles/$1" "$HOME/.$1"
}

# vim
ln_dot vimrc

# tmux
ln_dot tmux.conf
safe_ln "$HOME/dotfiles/tmux-powerline-setting/.tmux-powerlinerc" "$HOME/.tmux-powerlinerc"

# zsh
ln_dot zshrc
ln_dot zshenv

# other
ln_dot gitconfig
ln_dot inputrc

if [ -e $HOME/.vimrc ]; then
	rm $HOME/.vimrc
fi
ln -s $HOME/dotfiles/vimrc/vimrc $HOME/.vimrc
git submodule update --init
mkdir -p ~/.neobundle
cd ~/.neobundle
git clone https://github.com/Shougo/neobundle.vim.git
cd ~/dotfiles/
vim -s viminit
touch ~/.z

cd ~/dotfiles/nyancat
make
