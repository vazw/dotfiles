# my personal config files for Voidlinux
### Packages list to install:
<img align="right" src="https://github.com/vazw/dotfiles/blob/main/screenshot/2022-10-19-02-52-23_418x102.png">
I prefer to disable picom :D

<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2022-10-19-02-52-46_1440x31.png">

<img src="https://github.com/vazw/dotfiles/blob/main/screenshot/2022-10-19-02-42-50_1440x900.png">


Desktop stuff
`````
wmname          -   window manager naming
xorg            -   X11 server
xf86-video-*    -   garphic-driver : xf86-video-amdgpu xf86-video-intel xf86-video-nouveua xf86-video-ati
xsetroot        -   X11 config helper
xwinwrap        -   X11 background
feh             -   wallpapaer stuff
xsettingsd      -   X11 settings
polkit          -   Policy Authorization Toolkit
python          -   a snake?
python3-pip     -   :P
python3-dbus    -   python binding dbus
python3-cython  -   cpython
nodejs          -   nodejs for npm
lightdm         -   Desktop Manager
lightdm-webkit2-greeter - an engine for nody-greeter
nody-greeter    -   more rice login screen
bspwm           -   desktop environment
betterlockscreen -  lock screen
sxhkd           -   keyborads shortcut
NetworkManager  -   Networking
polybar         -   task bar
ranger          -   files manager
ueberzug        -   Draw image on terminal
rofi            -   app launcher
rofi-emoji      -   Emoji typing
dunst           -   notification
picom           -   tranparent background
alacritty       -   terminal-emulator
zsh             -   shell
maim            -   screenshot
xclip           -   clipboard 
acpi            -   battery thermal sensor 
light           -   blacklight control
`````

Sound Driver

`````
pulseaudio      -   audio driver
apulse          -   alsa plugin for pulse audio
pavucontrol     -   pulseaudio volume control
pamixer         -   pulseaudio mixer
`````

optional
`````
neovim          -   PDE
git             -   git
firefox         -   browser
mpd             -   Music player
mpc             -   mpd controller
mpv             -   Video player
htop            -   task manager
neofetch        -   show system info
unzip           -   zip files
obs-studio      -   screen recording
docker          -   isolated network
tmux            -   terminal 
`````

rofi stuff
`````sh
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
./setup.sh
`````

zsh oh my zsh
`````sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
`````

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

lastly don't forget to put this to '.xinitrc'
`````sh
exec bspwm
`````

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
