#!/bin/bash

ls -lA .dots/ | tail -n +2 | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{}
ls -lA bin/ | tail -n +2 | awk '{ print $NF }' | xargs -I{} sudo ln -fs $(pwd)/bin/{} /usr/local/bin/{}
mkdir -p /home/$USER/.config/nvim
ln -fs $(pwd)/.dots/.vimrc /home/$USER/.config/nvim/init.vim
ln -fs $(pwd)/vim/UltiSnips /home/$USER/.config/nvim/UltiSnips
test ! -L /home/$USER/.git-template && ln -fs $(pwd)/.git-template /home/$USER/.git-template
mkdir /home/$USER/.vim/undodir -p
source /home/$USER/.bashrc

