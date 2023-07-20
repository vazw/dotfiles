#!/bin/bash

hyprctl reload
pkill waybar
~/.config/hypr/scripts/statusbar &
