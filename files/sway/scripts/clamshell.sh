#!/usr/bin/bash
if cat /proc/acpi/button/lid/LID/state | grep -q open; then
    swaymsg output <eDP-1> enable && brillo -I
else
    brillo -O && swaymsg output <eDP-1> disable && swaylock
fi
