# my personal config files

I've switched to Debian 12 with sway

<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2.png">
<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/3.png">
<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/1.png">

### Packages list to install:
Desktop stuff
`````sh
sudo apt install -y git micro zram-tools neofetch exa timeshift sway waybar swaylock swayidle swaybg swayidle lxappearance policykit-1-gnome network-manager network-manager-gnome thunar thunar-archive-plugin thunar-volman file-roller alacritty mtools dosfstools acpi acpid avahi-daemon gvfs-backends grim  grimshot slurp dunst wofi wayland-protocols xwayland libgtk-layer-shell-dev brightnessctl wl-clipboard dex jq build-essential xdg-desktop-portal-wlr kvantum iwd
`````
Installation
`````sh
# clone this repo
git clone https://github.com/vazw/dotfiles
cd dotfiles
# Install sway and it's dependencies
./install.sh

# Install Nerd Fonts
./nerdfonts.sh
`````

