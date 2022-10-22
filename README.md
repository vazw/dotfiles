# my personal config files for Voidlinux
<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2022-10-19-02-52-23_418x102.png">

<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2022-10-19-02-52-46_1440x31.png">

<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2022-10-19-02-42-50_1440x900.png">

### Packages list to install:
Desktop stuff
`````sh
sudo xbps-install wmname xorg xf86-video-amdgpu xf86-video-intel xf86-video-nouveau xf86-video-ati xsetroot xwinwrap feh xsettingsd polkit python python3-pip python3-dbus dbus python3-Cython nodejs lightdm lightdm-webkit2-greeter bspwm sxhkd NetworkManager polybar ranger ueberzug rofi rofi-emoji dunst picom alacritty zsh scrot xclip acpi light nerd-fonts font-awesome pulseaudio apulse pavucontrol pamixer neovim git firefox htop neofetch unzip obs tmux xz curl gcc clang gobject-introspection pkg-config font-iosevka make font-TLWG font-adobe-source-code-pro numlockx light-locker 
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
| Super + r        | Run as Root        |
| Super + c        | Close a Window     |
| Super + x        | PowerMenu  |
| Super + w        | App Launcher  |
| Super + s        | Screen Menu  |
| Super + n        | Network Menu  |
| Super + e        | Emoji Menu  |
| Super + f | Toggle Full Screen Mode |
| Super + (1-9)        | Switch Workspace  |


## nody-greeter - more rice login screen


```sh
git clone --recursive https://github.com/JezerM/nody-greeter.git
cd nody-greeter
npm install
npm run rebuild
npm run build
sudo node make install
```

This will rebuild **electron** along with **node-gtk**, compile typescript with `npx tsc`, and then build the package root directory inside `build/unpacked`. Later, install it with `node make install`.

Also, you can package `build/unpacked` to whatever you want, like **.deb** with:
```sh
dpkg-deb --root-owner-group --build unpacked
```

Setting up with LightDM 

Inside `/etc/lightdm/lightdm.conf`, below a Seat configuration, add:
```
greeter-session=nody-greeter
```


Install nody-greeter+Void-theme
Run the next commands to build Void theme:

```sh
git clone https://github.com/JezerM/lightdm-void-theme.git
cd lightdm-void-theme
npm install
npm run build
```

Then, copy the **dist** directory into `/usr/share/web-greeter/themes/`:

```sh
sudo cp -r ./dist /usr/share/web-greeter/themes/lightdm-void-theme
```

Afterwards, set your theme as `lightdm-void-theme` inside
web-greeter/nody-greeter/sea-greeter's config file (`/etc/lightdm/web-greeter.yml`).


```sh
git clone https://github.com/JezerM/lightdm-void-theme.git
cd lightdm-void-theme
npm install
npm run build
```

Then, copy the **dist** directory into `/usr/share/web-greeter/themes/`:

```sh
sudo cp -r ./dist /usr/share/web-greeter/themes/lightdm-void-theme
```

Afterwards, set your theme as `lightdm-void-theme` inside
web-greeter/nody-greeter/sea-greeter's config file (`/etc/lightdm/web-greeter.yml`).

[nody-greeter]: https://github.com/JezerM/nody-greeter "Nody Greeter"

## VoidLinux shutdown | reboot

Shutdown and Reboot solution

!!!!Warning: NEVER edit /etc/sudoers directly! Always use the visudo command. 
`````sh
# since VOidlinux don't have systemctl we neet to excute sudo for shutdown or reboot 
# each time to be able to properly shutdown the machine
# in root user
sudo visudo
# find this line and add

%wheel ALL=(ALL:ALL) NOPASSWD: NOPASSWD:/usr/bin/halt,/usr/bin/poweroff,/usr/bin/reboot,/usr/bin/shutdown,/usr/bin/zzz,/usr/bin/ZZZ

# source : https://darknesscode.xyz/notes/shutdown-void-linux/?fbclid=IwAR0IWmTLqpQC8Yw8x14J1WiXOGdXRuCothJW9faM1PbS15S17afNXXBiY6U
`````
