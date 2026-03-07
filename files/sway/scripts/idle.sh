#!/usr/bin/sh

pidof swayidle && pkill swayidle
sleep 2

swayidle -w \
    timeout 600 'swaylock -f' \
    timeout 660 'brillo -O; swaymsg "output * power off"' \
    timeout 1080 'loginctl suspend' \
        resume 'swaymsg "output * power on"; brillo -I' \
    before-sleep 'swaymsg "output * power on"; playerctl pause; pidof swaylock || swaylock -f' 

    # after-resume 'swaymsg "output * power on"; brillo -I' \
# timeout 1070 'loginctl suspend' \

# swayidle -w \
#     timeout 1070 \
#     'loginctl suspend-then-hibernate' \
#     timeout 770 \
#     'brillo -O; swaymsg "output * power off"' \
#     resume 'swaymsg "output * power on"; brillo -I' \
#     after-resume 'swaymsg "output * power on"; brillo -I; swaylock' \
#     before-sleep 'playerctl pause;swaymsg "output eDP-1 power on"'


    # after-resume 'swaymsg "output * power on"; brillo -I; swaylock' \
