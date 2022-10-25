#!/bin/bash

# vazw
# check for multi screen

_Nscreen=$(xrandr --query | grep " connected" -c)

if [[ $_Nscreen -ge 2 ]]; then
    bash $HOME/.screenlayout/2monrc.sh
fi
