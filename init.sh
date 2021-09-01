#!/bin/bash

mkdir -p /home/$USER/.local/bin
ls -lA .dots/ | tail -n +2 | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{}
ln -fTs $(pwd)/.i3 /home/$USER/.i3
mkdir -p /home/$USER/.config/nvim
ln -fs $(pwd)/.dots/.vimrc /home/$USER/.config/nvim/init.vim
mkdir /home/$USER/.vim/undodir -p
source /home/$USER/.bashrc

