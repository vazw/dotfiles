# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:
let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop xdg-desktop-portal
      systemctl --user start xdg-desktop-portal
      systemctl start asusd
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
      gsettings set "$gnome_schema" icon-theme 'Adwaita'
      gsettings set "$gnome_schema" cursor-theme 'Catppuccin-Mocha-Dark-Cursors'
      gsettings set "$gnome_schema" font-name 'Sans 10'
    '';
  };


in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
    # Use flakes
  nix = {
      package = pkgs.nixFlakes;
      extraOptions = "experimental-features = nix-command flakes";
      };
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        (import (builtins.fetchTarball {
          url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
        }))
        (self: super: {
          neovim = super.neovim.override {
          viAlias = true;
          vimAlias = true;
          };
        })
      ];
    };
    # Use the systemd-boot EFI boot loader.
    boot.loader = {
	grub = {
	  enable = true;
	  devices = ["nodev"];
	  efiSupport = true;
	  useOSProber = true;
	};
    };

  systemd = {
    # User services here.
    user = {
      services = {
        kanshi = {
          description = "kanshi daemon";
          serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.kanshi}/bin/kanshi'';
          };
        };
      };
      # units = {
      #   asusd.wantedBy = ["default.target"];
      # };
    };
    # System services here.
    targets = {
      asusd.after = ["default.target"];
    };
  };
  
  networking = {
    useDHCP = lib.mkDefault false;
    hostName = "nixos";
    # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  };

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  # Enable sound.
  sound.enable = true;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
      noto-fonts-emoji
      tlwg
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    };
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vaz = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"  # Enable ‘sudo’ for the user. 
      "networkmanager" 
      "video" 
      "kvm"
      "libvirtd"
      "qemu-libvirtd"
      "docker"
      ]; 
    shell = pkgs.bash;
    packages = with pkgs; [ 
      sway
      wayland
      tree
      alacritty
      neofetch 
      waybar
      wlogout
      wofi
      ranger 
      brillo
      wl-clipboard
      wofi-emoji
      swaybg
      sway-contrib.grimshot
      networkmanagerapplet
      xdg-desktop-portal-wlr
      clipman
      gnome.gnome-keyring
      swayr
      pavucontrol
      power-profiles-daemon
      blueberry
      pamixer
      slurp
      autotiling
      libinput-gestures
      nodejs_20
      python3Full
      graphite-gtk-theme
      keepassxc
      wdisplays
      gnome3.adwaita-icon-theme
      dracula-theme
      blender
      xdg-utils
      dconf
      starship
      xfce.thunar
      xdg-user-dirs
      wlroots
      btop
      wlr-randr
       # Video/Audio
      feh               # Image Viewer
      mpv               # Media Player
      vlc               # Media Player
      dunst 
      dbus-sway-environment
      configure-gtk
      gnome.adwaita-icon-theme
      kitty
      chromium

      # Apps
      appimage-run      # Runs AppImages on NixOS
      firefox           # Browser
      remmina           # XRDP & VNC Client
      obs-studio
      telegram-desktop
      lazygit
      wtype

      gnome.file-roller # Archive Manager
      okular            # PDF Viewer
      p7zip             # Zip Encryption
      rsync             # Syncer - $ rsync -r dir1/ dir2/
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip
      (catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        variant = "mocha";
      })
      catppuccin-cursors.mochaDark
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     fish
     gcc
     zig
     exa
     tmux
     jq
     libthai
     glib
     libnotify
     curl
     man
     cmake
     unzip
     docker-compose
     virt-manager
     libguestfs # needed to virt-sparsify qcow2 files
     libvirt
     qemu_kvm
     gtk-engine-murrine
     gtk_engines
     gsettings-desktop-schemas
     upower
     shared-mime-info
     pcmanfm
     killall
     asusctl
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs = {
    starship.enable = true;
    fish.enable = true;
    # enable sway window manager
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    waybar.enable = true;
    nm-applet.enable = true;
    light.enable = true;
    thunar = { 
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];

    };
    tmux.enable = true;
    tmux.plugins = with pkgs; [
	tmuxPlugins.sensible
	tmuxPlugins.resurrect
	tmuxPlugins.continuum
    ];
    dconf.enable = true;
    gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
    qemu.runAsRoot = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  # Docker
  virtualisation.docker.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";
  # Enable CUPS to print documents.
  # services.printing.enable = true;
  services = {
    openssh.enable = true;
    upower.enable = true;
    dbus.enable = true;
    gvfs.enable = true;
    # power profiles
    power-profiles-daemon.enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    xserver.libinput.enable = true;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="battery", KERNEL=="asus_wmi", RUN+="${pkgs.coreutils}/bin/echo 80 > /sys/class/power_supply/BATT/charge_control_end_theshold"
      '';
    asusd = {
      enable = true;
      enableUserService = true;
      asusdConfig = ''
        "bat_charge_limit": 80,
	'';
    };
  };


  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  qt.platformTheme = "qt5ct";
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

