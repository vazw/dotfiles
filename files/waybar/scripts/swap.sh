#!/bin/bash

THEME=$(darkman get)
# rm "$HOME/.config/waybar/style.css"
# cp "$HOME/.config/waybar/style_${THEME}.css" "$HOME/.config/waybar/style.css"
# swaymsg reload

rm "$HOME/.config/swaync/style.css"
cp "$HOME/.config/swaync/style_${THEME}.css" "$HOME/.config/swaync/style.css"
swaync-client --reload-css
