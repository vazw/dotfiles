#!/bin/bash

files=(
    "alacritty"
    "btop"
    "fish"
    "hypr"
    "lazygit"
    "neofetch"
    "nvim"
    "ranger"
    "sway"
    "tmux"
    "waybar"
    "wob"
    "wofi"
    "xsettingsd"
)

for item in ${files[@]} ;do
    cp ~/.config/"$item"/ -ru .
    echo "Updated $item"
done
