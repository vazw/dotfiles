#!/usr/bin/bash

pidof swayidle && pkill swayidle
sleep 2

swayidle -w \
    timeout 1070 'swaylock' \
    timeout 770 "brillo -O && swaymsg 'output * power off'" \
    resume "swaymsg 'output * power on' && brillo -I" 
# swayidle -w \
#     timeout 1070 'brillo -O && swaylock' \
#     timeout 770 'brillo -O && swaymsg "output * dpms off"' \
#     resume 'swaymsg "output * dpms on" && brillo -I' \
#     before-sleep 'brillo -O && swaylock'
