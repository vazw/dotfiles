# my personal config files for Voidlinux

<!--toc:start-->

- [my personal config files for Voidlinux](#my-personal-config-files-for-voidlinux)
  - [Packages list to install](#packages-list-to-install)
    - [Assume you've fresh installed Voidlinux and reboot into tty1](#assume-youve-fresh-installed-voidlinux-and-reboot-into-tty1)
    - [Desktop stuff](#desktop-stuff)
  - [runit](#runit)
  - [Installation](#installation)
  - [Keybind?](#keybind)
  - [Auto-Mount USB Drive](#auto-mount-usb-drive)
  - [Dark Theme](#dark-theme)
  - [Autologin](#autologin)
  <!--toc:end-->

<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2.png">
<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/3.png">
<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/1.png">

## Packages list to install

[Void Linux installation (NVMe, btrfs, LVM, full disk encryption using LUKS, 2FA-ish, SSD TRIM)](https://gist.github.com/tobi-wan-kenobi/bff3af81eac27e210e1dc88ba660596e)
[Graphics Drivers](https://docs.voidlinux.org/config/graphical-session/graphics-drivers/index.html)

#### Assume you've fresh installed Voidlinux and reboot into tty1

you may have to setup your network first if you got wifi connect it with wpa-supplicant config

```sh
wpa_passphrase your-ESSID your-passphrase | sudo tee /etc/wpa_supplicant.conf
sudo wpa_supplicant -c /etc/wpa_supplicant.conf -i your-NIC
```

if it's ethernet cable just check if dhcpcd is running and it's connected to Internet

#### Desktop stuff

this is my daily device (Asus Zenbook) usage config applications if you're on desktop-PC you may not want `acpi` or `light` stuff consider remove them as you needed

most important piece are `dbus` `sway` `waybar` `polkit` `wlogout` `elogind` for windows manager `pipewire` `wireplumber` `pavucontrol` for audio system `kitty` or `alacritty` for Terminal or pick your prefer. `rofi`,`sirula` for App Launcher
if you want to use `pulse-audio` instead take a look at [Voidlinux Documents](https://docs.voidlinux.org/)

```sh
sudo xbps-install feh polkit python python3-pip python3-dbus dbus python3-Cython nodejs sway NetworkManager Waybar lf wofi SwayNotificationCenter acpi light nerd-fonts fonts-awesome pipewire wireplumber pavucontrol pamixer neovim git firefox btop fastfetch unzip obs tmux xz curl gcc clang pkg-config font-iosevka make Fonts-TLWG cmake nwg-look sv-netmount xdg-utils wdisplays ghostty wlogout slurp wf-recorder wl-clipboard elogind Thunar noto-fonts-cjk noto-fonts-ttf noto-fonts-ttf-extra noto-fonts-emoji fonts-nanum-ttf font-emoji-one-color font-weather-icons tlp typst upower mpv mypaint nftables nmap NetworkManager-openvpn
```

## runit

Void using `runit` service control instead of `systemd` this is how to replace `dhcpcd` with `NetworkManager`

```sh
# avalable service list

ls /etc/sv/
```

```sh
# service that we're using list

ls /var/service/
```

```sh
# to link avalable service to use

sudo ln -s /etc/sv/<service-we-wanted> /var/service/
```

```sh
# if you don't want auto-startup but need service

sudo touch /etc/sv/<service>/down
```

to tell runit use the following commands with 'root' or 'sudo'

```sh
# sv up <services>
# sv down <services>
# sv restart <services>
# sv status <services>
```

Example : Use NetworkManager instead of dhcpcd

```sh
sudo unlink /var/service/dhcpcd
sudo ln -s /etc/sv/NetworkManager /var/service/
sudo sv up NetworkManager
```

NetworkManager.conf
using dnsmasq for dns cache and using cloned-mac-address as stable per connection
`scan-rand-mac-address` will random a mac-address on scan

```conf
[main]
dns=dnsmasq
plugins=keyfile

[keyfile]

[device]
wifi.scan-rand-mac-address=yes

[connection]
wifi.cloned-mac-address=stable
ethernet.cloned-mac-address=stable
connection.stable-id=${CONNECTION}/${BOOT}
```

## Installation

```sh
# clone this repo
git clone https://github.com/vazw/dotfiles
cd dotfiles
git checkout Void(wayland)
cp dotprofile ~/.profile
cp files/* ~/.config/
# then logout or restart
# Next login will auto trigger sway from tty1
cat <<EOF | sudo tee -a /etc/profile
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi
EOF
```

## Keybind?

| Keybinds              | Uses                      |
| --------------------- | ------------------------- |
| Super + \<hjkl>       | Focus Window Vim Motion   |
| Super + Enter         | Terminal                  |
| Super + Shift + Enter | Floating Terminal         |
| Super + Space         | Toggle Window Mode        |
| Super + q             | Close a Window            |
| Super + w             | Stack Horizontal Tab Mode |
| Super + s             | Stack Vertical Tab Mode   |
| Super + e             | Tile Mode                 |
| Super + Shift + e     | PowerMenu                 |
| Super + d             | App Launcher              |
| Super + n             | Thunar                    |
| Super + i             | Emoji Menu                |
| Super + f             | Thunar File Manager       |
| Super + F             | Toggle Full Screen Mode   |
| Super + (1-0)         | Switch Workspace (1-10)   |
| Super + left click    | Move Window               |
| Super + right click   | Resize window             |
| Super + p             | screenshot                |
| Super + Shift + p     | area-screenshot           |

and more customize can be done at `~/.config/sway/config.d/keymap`
many of them are my custom keyboard config try remove them if it's not suit your need

## Auto-Mount USB Drive

- enable Thunar Volume Management in Advanced Setting Tab

## Dark Theme

- install `darkman`

define XDG_DATA_DIRS to `.local/share`

```bash
export XDG_DATA_DIRS=$HOME/.local/share:$XDG_DATA_DIRS
```

then copy `darkman/dark-mode.d/` and `darkman/light-mode.d` to `~/.local/share`

when execute `darkman toggle` darkman will trigger script inside `dark-mode.d` and `light-mode.d` to manipulate your gtk config

## Autologin

[check agetty conf](https://man.voidlinux.org/agetty.8)
