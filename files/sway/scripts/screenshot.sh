#!/bin/bash

entries="Active Screen Output Area Window"

selected=$(printf '%s\n' $entries | wofi --style=$HOME/.config/wofi/style.widgets.css --conf=$HOME/.config/wofi/config.screenshot | awk '{print tolower($1)}')

case $selected in
    active)
        grimshot --notify save active ;;
    screen)
        grimshot --notify save screen ;;
    output)
        grimshot --notify save output ;;
    area)
        grimshot --notify save area ;;
    window)
        grimshot --notify save window ;;
esac
