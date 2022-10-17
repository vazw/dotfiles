# my personal config files for Voidlinux
### Packages list to install:

<img src="https://github.com/vazw/vazw/blob/main/1">

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
python3-pip      -   :P
python3-dbus    -   python binding dbus
lightdm         -   Desktop Manager
lightdm-webkit2-greeter  -   lightdm greeter
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
<img src="https://github.com/vazw/vazw/blob/main/2">
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
`````
git clone --depth=1 https://github.com/adi1090x/rofi.git
cd rofi
chmod +x setup.sh
./setup.sh
`````

zsh oh my zsh
`````
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
`````

Void runit service control
`````
# avalable service list

ls /etc/sv/
`````
`````
# service that we're using list

ls /var/service/
`````
`````
# to link avalable service to use

sudo ln -s /etc/sv/<service-we-wanted> /var/service/
`````
`````
# if you don't want auto-startup but need service

sudo touch /etc/sv/<service>/down
`````

to tell runit use the following commands with 'root' or 'sudo'
`````
# sv up <services>
# sv down <services>
# sv restart <services>
# sv status <services>
`````

Example : Use NetworkManager instead of dhcpcd
`````
sudo rm /var/service/dhcpcd
sudo ln -s /etc/sv/NetworkManager /var/service/
sudo sv up NetworkManager
`````

lastly don't forget to put this to '.xinitrc'
`````
exec bspwm
`````
