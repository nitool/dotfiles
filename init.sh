#!/usr/bin/env bash

ls -lA .dots/ | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{} ;
ls -lA .config/ | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.config/{} /home/$USER/.config/{}

dconf load /org/cinnamon/desktop/keybindings/ < dconf-settings.conf
