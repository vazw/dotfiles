#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#

# Current Theme
dir="$HOME/.config/rofi/powermenu"
theme='style'

# CMDs
lastlogin="$(last "$USER" | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7)"
uptime="$(uptime| sed -e 's/up //g' | tr -s ' ' | cut -d' ' -f3 | cut -d',' -f1)"
host=$(hostname)

# Options
hibernate='󰒲'
shutdown='⏻'
reboot='󰑓'
lock=''
logout=''
yes=''
no=''

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p " $USER@$host" \
        -mesg " Last Login: $lastlogin |  Uptime: $uptime Hr" \
        -theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$lock\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
            systemctl hibernate
        elif [[ $1 == '--reboot' ]]; then
            systemctl reboot
        elif [[ $1 == '--hibernate' ]]; then
            systemctl hybrid-sleep
        elif [[ $1 == '--logout' ]]; then
            bspc quit
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        run_cmd --shutdown
        ;;
    $reboot)
        run_cmd --reboot
        ;;
    $hibernate)
        run_cmd --hibernate
        ;;
    $lock)
        betterlockscreen -l
        ;;
    $logout)
        run_cmd --logout
        ;;
esac
