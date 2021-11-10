#!/bin/bash

mkdir -p /home/$USER/.local/bin
ls -lA .dots/ | tail -n +2 | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{}
ls bin/ | xargs -n 1 -I{} ln -fs $(pwd)/bin/{} /home/$USER/.local/bin/{}
ln -fTs $(pwd)/.i3 /home/$USER/.i3
mkdir -p /home/$USER/.config/nvim
ln -fs $(pwd)/.dots/.vimrc /home/$USER/.config/nvim/init.vim
ln -fs $(pwd)/coc-settings.json /home/$USER/.config/nvim/coc-settings.json
mkdir /home/$USER/.vim/undodir -p
source /home/$USER/.bashrc
