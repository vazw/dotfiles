#!/bin/bash

THEME=$(darkman get)
rm "$HOME/.config/waybar/style.css"
cp "$HOME/.config/waybar/style_${THEME}.css" "$HOME/.config/waybar/style.css"

rm "$HOME/.config/swaync/style.css"
cp "$HOME/.config/swaync/style_${THEME}.css" "$HOME/.config/swaync/style.css"
swaymsg reload
swaync-client --reload-css
