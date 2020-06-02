#!/usr/bin/env bash

ls -lA .dots/ | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{} ;
test ! -L /home/$USER/.git-template && ln -fs $(pwd)/.git-template /home/$USER/.git-template

dconf load /org/cinnamon/desktop/keybindings/ < dconf-settings.conf
mkdir ~/.vim/undodir -p

