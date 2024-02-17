#!/usr/bin/bash
if cat /proc/acpi/button/lid/LID/state | grep -q open; then
    swaymsg output <eDP-1> enable && pkexec brillo -I
else
    pkexec brillo -O && swaymsg output <eDP-1> disable && swaylock
fi
