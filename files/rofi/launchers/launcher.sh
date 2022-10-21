#!/usr/bin/env bash

dir="$HOME/.config/rofi/launchers"
theme='style'

## Run
rofi \
    -show drun\
    -theme ${dir}/${theme}.rasi
