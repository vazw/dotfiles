#!/usr/bin/bash

sed -i 's/^gtk-theme-name=.*/gtk-theme-name="Adwaita"/; s/^gtk-icon-theme-name=.*/gtk-icon-theme-name="Papirus"/' "$HOME/.gtkrc-2.0"
sed -i 's/^gtk-theme-name=.*/gtk-theme-name=Adwaita/; s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=Papirus/' "$HOME/.config/gtk-3.0/settings.ini"
sed -i 's/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=0/; s/^gtk-cursor-theme-name=.*/gtk-cursor-theme-name=Breeze_Obsidian' "$HOME/.config/gtk-3.0/settings.ini"
sed -i 's/^include.*\.conf/include light-theme.conf/' "$HOME/.config/kitty/kitty.conf"
sed -i 's/icon_theme.*\.conf/icon_theme Papirus/' "$HOME/.config/sway/config"

"$HOME/.config/sway/scripts/import-gsettings"
"$HOME/.config/waybar/scripts/swap.sh"

pkill -10 kitty
