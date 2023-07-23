#!/bin/sh

sudo apt install -y git micro zram-tools neofetch exa timeshift sway waybar swaylock swayidle swaybg swayidle lxappearance policykit-1-gnome network-manager network-manager-gnome thunar thunar-archive-plugin thunar-volman file-roller alacritty mtools dosfstools acpi acpid avahi-daemon gvfs-backends grim  grimshot slurp dunst wofi wayland-protocols xwayland libgtk-layer-shell-dev brightnessctl wl-clipboard dex jq build-essential xdg-desktop-portal-wlr kvantum libglib2.0-bin light fonts-thai-tlwg fonts-arphic-ukai fonts-arphic-uming fonts-ipafont-mincho fonts-ipafont-gothic fonts-unfonts-core wtype fonts-noto-color-emoji yad

sudo systemctl enable acpid
sudo systemctl enable avahi-daemon

xdg-user-dirs-update

cp .bashrc ~/
cp .profile ~/
cp files/* -ru ~/.config/
