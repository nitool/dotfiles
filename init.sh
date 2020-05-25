#!/usr/bin/env bash

ls -lA .dots/ | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{} ;
ln -fs $(pwd)/.git-template /home/$USER/.git-template ;

dconf load /org/cinnamon/desktop/keybindings/ < dconf-settings.conf

