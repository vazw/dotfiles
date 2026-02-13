#!/usr/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "ignorepkg=linux-firmware-nvidia" > /etc/xbps.d/01-nvidia.conf
echo "ignorepkg=wireguard-dkms" > /etc/xbps.d/02-wireguard-dkms.conf
cat << EOF > /etc/profile

if [ -f "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi
EOF

cat << EOF > /etc/sysctl.conf
net.ipv4.ip_forward = 1
vm.dirty_background_bytes = 33554432
vm.dirty_bytes = 134217728
net.ipv4.conf.all.drop_unicast_in_l2_multicast = 1
net.ipv4.tcp_timestamps = 0
fs.inotify.max_user_watches = 494462
EOF

cat << EOF > /lib/firmware/hda-jack-retask.fw
[codec]
0x10ec0294 0x10431f12 0

[pincfg]
0x12 0x40000000
0x13 0x411111f0
0x14 0x411111f0
0x15 0x411111f0
0x16 0x411111f0
0x17 0x90170110
0x18 0x411111f0
0x19 0x03a19020
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x4066852d
0x1e 0x411111f0
0x1f 0x411111f0
0x21 0x04211020
EOF


echo "options snd_hda_intel patch=hda-jack-retask.fw" | sudo tee /etc/modprobe.d/hda-jack-retask.conf

cat << EOF > /etc/dracut.conf.d/00-compress.conf
install_items+=" /usr/bin/lz4 "
compress="lz4"
omit_dracutmodules+=" qemu "
EOF

cat << EOF > /etc/dracut.conf.d/10-crypt.conf
install_items+=" /boot/volume.key /etc/crypttab "
EOF

xbps-install -Suy void-repo-nonfree void-repo-void-repo-multilib
xbps-install -y feh polkit python python3-pip python3-dbus dbus \
  python3-Cython nodejs sway NetworkManager Waybar lf wofi \
  SwayNotificationCenter font-awesome pipewire wireplumber pavucontrol \
  pamixer neovim git firefox btop fastfetch unzip wget \
  obs tmux xz curl gcc clang pkg-config font-iosevka make Fonts-TLWG cmake \
  nwg-look sv-netmount wdisplays ghostty wlogout slurp wf-recorder \
  wl-clipboard elogind Thunar noto-fonts-cjk noto-fonts-ttf \
  noto-fonts-ttf-extra noto-fonts-emoji fonts-nanum-ttf font-emoji-one-color \
  font-weather-icons tlp typst upower mpv mypaint nftables \
  nmap NetworkManager-openvpn xdg-utils xdg-user-dirs xdg-user-dirs-gtk \
  luarocks qbittorrent void-docs mesa mesa-dri gimp grim grimshot \
  qemu libvirt qalculate rust rustup cargo xtools zig wifi-firmware \
  wireguard network-manager-applet blueman brillo bpftool \
  thunar-volman thunar-archive-plugin thunar-media-tags-plugin kitty dex \
  autotiling clipman xdg-desktop-portal xdg-desktop-portal-wlr swayrd \
  darkman socklog-void podman podman-compose usbguard apparmor polkit-elogind \
  polkit-gnome fprint keepassxc chromium nvtop darktable android-file-transfer \
  android-tools android-udev-rules inetutils bind-utils sof-firmware \
  alsa-firmware libjack-pipewire alsa-tools

## AMD GPU
xbps-install -y mesa-opencl mesa-vaapi mesa-vdpau mesa-vulkan-radeon \
  vulkan-loader Vulkan-ValidationLayers Vulkan-Utility-Libraries 

## Steam
xbps-install -y steam SDL2-32bit Vulkan-Utility-Libraries-32bit \
  Vulkan-ValidationLayers-32bit wayland-32bit vulkan-loader-32bit \
  vkBasalt-32bit pipewire-32bit mesa-32bit mesa-dri-32bit \
  mesa-vulkan-radeon-32bit pipewire-32bit gamescope
  
unlink /var/service/dhcpcd
unlink /var/service/wpa_supplicant
unlink /var/service/agetty-tty3
unlink /var/service/agetty-tty4
unlink /var/service/agetty-tty5
unlink /var/service/agetty-tty6
ln -s /etc/sv/NetworkManager /var/service/
sv up NetworkManager

cat << EOF > /etc/NetworkManager/NetworkManager.conf
[main]
dns=dnsmasq
plugins=keyfile

[keyfile]
unmanaged-devices=interface-name:virbr0

[device]
wifi.scan-rand-mac-address=no

[connection]
wifi.cloned-mac-address=stable
ethernet.cloned-mac-address=stable
connection.stable-id=\${CONNECTION}/\${BOOT}
EOF

ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/socklog-unix /var/service/
ln -s /etc/sv/nanoklogd /var/service/
ln -s /etc/sv/bluetoothd /var/service/
ln -s /etc/sv/ntpd /var/service/
ln -s /etc/sv/podman /var/service/
ln -s /etc/sv/podman-docker /var/service/
ln -s /etc/sv/polkitd /var/service/
ln -s /etc/sv/usbguard /var/service/
ln -s /etc/sv/tlp /var/service/

cp -r "$SCRIPT_DIR"/services/system/* /etc/sv/
# ln -s /etc/sv/warp-svc /var/service/
ln -s /etc/sv/asus-numpad /var/service/

mkdir -p /etc/pipewire/pipewire.conf.d
ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
mkdir -p /etc/alsa/conf.d
ln -s /usr/share/alsa/alsa.conf.d/50-pipewire.conf /etc/alsa/conf.d
ln -s /usr/share/alsa/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d

echo "/usr/lib/pipewire-0.3/jack" > /etc/ld.so.conf.d/pipewire-jack.conf
ldconfig

ln -s /usr/share/applications/polkit-gnome-authentication-agent-1.desktop /etc/xdg/autostart/
ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart/
