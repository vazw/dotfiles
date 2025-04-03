#!/usr/bin/bash

sed -i 's/^gtk-theme-name=.*/gtk-theme-name="Adwaita-dark"/; s/^gtk-icon-theme-name=.*/gtk-icon-theme-name="Papirus-Dark"/' "$HOME/.gtkrc-2.0"
sed -i 's/^gtk-theme-name=.*/gtk-theme-name=Adwaita-dark/; s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=Papirus-Dark/' "$HOME/.config/gtk-3.0/settings.ini"
sed -i 's/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=1/; s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=Breeze_Contrast' "$HOME/.config/gtk-3.0/settings.ini"
sed -i 's/^include.*/include dark-theme.conf/' "$HOME/.config/kitty/kitty.conf"
sed -i 's/icon_theme.*\.conf/icon_theme Papirus-Dark/' "$HOME/.config/sway/config"

"$HOME/.config/sway/scripts/import-gsettings"
"$HOME/.config/waybar/scripts/swap.sh"

pkill -10 kitty
