# my personal config files for Voidlinux
A combination between rice + light : <br />
let's call this lice!

<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2.png">
<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/3.png">
<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/1.png">

### Packages list to install:
Desktop stuff
`````sh
sudo xbps-install wmname xorg xsetroot xwinwrap feh xsettingsd polkit python python3-pip python3-dbus dbus python3-Cython nodejs lightdm lightdm-webkit2-greeter bspwm sxhkd NetworkManager polybar ranger ueberzug rofi rofi-emoji dunst picom alacritty zsh scrot xclip acpi light nerd-fonts font-awesome pulseaudio apulse pavucontrol pamixer neovim git firefox htop neofetch unzip obs tmux xz curl gcc clang gobject-introspection pkg-config font-iosevka make Font-TLWG font-adobe-source-code-pro cmake mpd mpc udiskie lxappearance breeze-gtk breeze-icons sv-netmount xdg-utils arandr
`````
Installation
`````sh
# clone this repo
git clone https://github.com/vazw/dotfiles
cd dotfiles
./setup.sh
`````


zsh oh my zsh
`````sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
`````

## runit
Void runit service control
`````sh
# avalable service list

ls /etc/sv/
`````
`````sh
# service that we're using list

ls /var/service/
`````
`````sh
# to link avalable service to use

sudo ln -s /etc/sv/<service-we-wanted> /var/service/
`````
`````sh
# if you don't want auto-startup but need service

sudo touch /etc/sv/<service>/down
`````

to tell runit use the following commands with 'root' or 'sudo'
`````sh
# sv up <services>
# sv down <services>
# sv restart <services>
# sv status <services>
`````

Example : Use NetworkManager instead of dhcpcd
`````sh
sudo rm /var/service/dhcpcd
sudo ln -s /etc/sv/NetworkManager /var/service/
sudo sv up NetworkManager
`````

## Keybind?

| Keybinds       | Uses        |
| -------------- | ----------- |
| Super + Enter    | Terminal    |
| Super + Space    | Toggle Window Mode      |
| Super + c        | Close a Window     |
| Super + x        | PowerMenu  |
| Super + w        | App Launcher  |
| Super + s        | Screen Menu  |
| Super + n        | Network Menu  |
| Super + e        | Emoji Menu  |
| Super + f | Toggle Full Screen Mode |
| Super + (1-9)        | Switch Workspace  |
| Super + left click        | Move Window  |
| Super + right click   | Resize window  |

## nody-greeter - more rice login screen
Install nody-greeter+Void-theme

https://github.com/JezerM/nody-greeter <br />
https://github.com/JezerM/lightdm-void-theme

## VoidLinux shutdown | reboot

Shutdown and Reboot solution

!!!!Warning: NEVER edit /etc/sudoers directly! Always use the visudo command. 
`````sh
# since VOidlinux don't have systemctl we neet to excute sudo for shutdown or reboot 
# each time to be able to properly shutdown the machine
# in root user
sudo visudo
# find this line and add

%wheel ALL=(ALL:ALL) NOPASSWD:/usr/bin/shutdown,/usr/bin/reboot,/usr/bin/suspend,/usr/bin/udiskie,/usr/bin/pkill,/usr/bin/zzz,/usr/bin/ZZZ,/usr/bin/halt,/usr/bin/poweroff

# source : https://darknesscode.xyz/notes/shutdown-void-linux/?fbclid=IwAR0IWmTLqpQC8Yw8x14J1WiXOGdXRuCothJW9faM1PbS15S17afNXXBiY6U
`````
more info about some I have problem done read TODO file.
