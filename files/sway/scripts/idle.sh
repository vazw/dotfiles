#!/usr/bin/sh

pidof swayidle && pkill swayidle
sleep 2

swayidle -w \
    timeout 1070 \
    'loginctl suspend' \
    timeout 770 \
    'brillo -O; swaymsg "output * power off"' \
    resume 'swaymsg "output * power on"; brillo -I' \
    after-resume 'swaymsg "output * power on"; brillo -I; swaylock' \
    before-sleep 'playerctl pause;swaymsg "output eDP-1 power on"'


    # after-resume 'swaymsg "output * power on"; brillo -I; swaylock' \
