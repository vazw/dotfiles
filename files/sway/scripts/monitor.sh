#!/bin/env sh

if [ "$(swaymsg -t get_outputs | grep -c DP)" -gt 1 ]; then
    xrandr --output "$(xrandr | awk '/1920x1080/ {print $1}' | head -n 1)" --primary
else
    xrandr --output eDP-1 --primary
fi
