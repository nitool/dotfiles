#!/usr/bin/env bash

ls -lA .dots/ | awk '{ print $NF }' | xargs -I{} ln -fs $(pwd)/.dots/{} /home/$USER/{} ;

dconf load /org/cinnamon/desktop/keybindings/ < dconf-settings.conf

