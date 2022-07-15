#!/bin/bash

echo "creating required directories"
mkdir -p /home/$USER/.local/bin
mkdir -p /home/$USER/.config/nvim
mkdir -p /home/$USER/.vim/undodir

echo "creating symlinks"
echo "- dots"
ls -lA .dots/ | tail -n +2 | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{}
echo "- bin"
ls bin/ | xargs -n 1 -I{} ln -fs $(pwd)/bin/{} /home/$USER/.local/bin/{}
echo "- i3"
ln -fTs $(pwd)/.i3 /home/$USER/.i3
echo "- nvim"
ln -fs $(pwd)/init.lua /home/$USER/.config/nvim/init.lua
ln -fs $(pwd)/nvim-lua /home/$USER/.config/nvim/lua
echo "- kitty"
ln -fs $(pwd)/kitty.conf /home/$USER/.config/kitty/kitty.conf

echo "reloading bash config"
source /home/$USER/.bashrc

