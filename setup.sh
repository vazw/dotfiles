#!/usr/bin/env bash
## Copy from some source and edit by me.
## Github : @vazw
## Colors ----------------------------
Color_Off='\033[0m'
BBlack='\033[1;30m' BRed='\033[1;31m'    BGreen='\033[1;32m' BYellow='\033[1;33m'
BBlue='\033[1;34m'  BPurple='\033[1;35m' BCyan='\033[1;36m'  BWhite='\033[1;37m'

## Directories ----------------------------
DIR=$(pwd)
FONT_DIR="$HOME/.local/share/fonts"
INSTALL_DIR="$HOME/.config"

# Install Fonts
install_fonts() {
    echo -e ${BBlue}"\n[*] Installing fonts..." ${Color_Off}
    if [[ -d "$FONT_DIR" ]]; then
        cp -rf $DIR/fonts/* "$FONT_DIR"
    else
        mkdir -p "$FONT_DIR"
        cp -rf $DIR/fonts/* "$FONT_DIR"
    fi
    echo -e ${BYellow}"[*] Updating font cache...\n" ${Color_Off}
    fc-cache
}

# Install Themes
install_themes() {
    if [[ -d "$INSTALL_DIR" ]]; then
        echo -e ${BPurple}"[*] Creating a backup of your exited .config files..." ${Color_Off}
        mv "$INSTALL_DIR" "${INSTALL_DIR}.${USER}"
    fi
    echo -e ${BBlue}"[*] Installing .configs..." ${Color_Off}
    { mkdir -p "$INSTALL_DIR"; cp -rf $DIR/files/* "$INSTALL_DIR"; }
    cp -rf "$DIR/.Xresources.d" "$HOME"
    cp -rf "$DIR/.Xresources" "$HOME"

    if [[ -f "$INSTALL_DIR/bspwm/bspwmrc" ]]; then
        feh --bg-scale "${HOME}/.config/bspwm/wall.png"
        mkdir ~/Musics
        mkdir ~/Musics/playlists
        mkdir ~/.local/share/mpd
        touch ~/.local/share/mpd/log
        touch ~/.local/share/mpd/database
        touch ~/.local/share/mpd/sticker.sql
        echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
        exit 0
    else
        echo -e ${BRed}"[!] Failed to install.\n" ${Color_Off}
        exit 1
    fi
}

# Main
main() {
    install_fonts
    install_themes
}

main
