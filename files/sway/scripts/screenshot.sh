#!/bin/bash

entries="Active Screen Output Area Window"

selected=$(printf '%s\n' $entries | wofi --style=$HOME/.config/wofi/style.widgets.css --conf=$HOME/.config/wofi/config.screenshot | awk '{print tolower($1)}')

case $selected in
    active)
        grimshot --notify save active ~/Pictures/ScreenShots/$(date +%FT%R:%S).png ;;
    screen)
        grimshot --notify save screen ~/Pictures/ScreenShots/$(date +%FT%R:%S).png ;;
    output)
        grimshot --notify save output ~/Pictures/ScreenShots/$(date +%FT%R:%S).png ;;
    area)
        grimshot --notify save area ~/Pictures/ScreenShots/$(date +%FT%R:%S).png ;;
    window)
        grimshot --notify save window ~/Pictures/ScreenShots/$(date +%FT%R:%S).png ;;
esac
