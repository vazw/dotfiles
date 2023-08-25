# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:
# let

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
#  configure-gtk = pkgs.writeTextFile {
#    name = "configure-gtk";
#    destination = "/bin/configure-gtk";
#    executable = true;
#    text = let
#      schema = pkgs.gsettings-desktop-schemas;
#      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
#    in ''
#      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
#      gnome_schema=org.gnome.desktop.interface
#      gsettings set $gnome_schema gtk-theme 'Dracula'
#      gsettings set "$gnome_schema" icon-theme 'Adwaita'
#      gsettings set "$gnome_schema" cursor-theme 'Catppuccin-Mocha-Dark-Cursors'
#      gsettings set "$gnome_schema" font-name 'Sans 10'
#    '';
#  };
# 
# 
#  in

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
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "Iosevka" ]; })
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
      bspwm
      sxhkd
      polybarFull
      xorg.xdpyinfo
      xorg.libX11
      xtitle
      tree
      alacritty
      neofetch 
      (rofi.override {plugins=[rofi-emoji];})
      xclip
      ranger 
      brillo
      networkmanagerapplet
      wmname
      scrot
      betterlockscreen
      lightdm-gtk-greeter

      gnome.gnome-keyring
      pavucontrol
      tlp
      blueberry
      pamixer
      nodejs_20
      python3Full
      keepassxc
      dracula-theme
      blender
      xdg-utils
      dconf
      starship
      xfce.thunar
      xdg-user-dirs
      btop
      mpd
      mpc-cli

       # Video/Audio
      feh               # Image Viewer
      mpv               # Media Player
      vlc               # Media Player
      dunst 
      gnome.adwaita-icon-theme
      kitty
      chromium

      # Apps
      appimage-run      # Runs AppImages on NixOS
      librewolf-unwrapped
      remmina           # XRDP & VNC Client
      obs-studio
      telegram-desktop
      lazygit
      gtk3
      mongodb-compass
      mysql-workbench

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
      qbittorrent
      xsettingsd
      lxappearance
      ueberzug
      papirus-icon-theme

    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment = {
     systemPackages = with pkgs; [
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
       upower
       shared-mime-info
       pcmanfm
       killall
     ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    starship.enable = true;
    fish.enable = true;
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
    tmux = { 
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
	continuum
        resurrect
	sensible
      ];
      extraConfig = ''
	set -g @continuum-boot 'on'
	set -g @continuum-restore 'on'
	set -g @resurrect-strategy-nvim 'session'
	set -g @resurrect-processes 'nvim hx cat less more tail watch'
	'';
    };
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


  systemd = {
    user.services.betterlockscreen = {
      description = "Lock screen when going to sleep/suspend";
      before = [ "sleep.target" "suspend.target" ];
      environment = { DISPLAY=":0";};
      serviceConfig = {
        Type = "simple";
        ExecStart = ''${pkgs.betterlockscreen}/bin/betterlockscreen --lock'';
        TimeoutSec="infinity";
        };
      postStart = "${pkgs.coreutils}/bin/sleep 1";
      wantedBy = [ "sleep.target" "suspend.target" ];
      };
  };

  services = {
    # printing.enable = true;
    openssh.enable = true;
    upower.enable = true;
    dbus.enable = true;
    mpd.enable = true;
    gvfs.enable = true;
    xserver = {
      enable = true;
      libinput = {
        enable = true;
	touchpad = { 
	  naturalScrolling = true;
	  accelSpeed = "0.5";
	  };
	};
      layout = "us,th";
      xkbOptions = "grp:caps_toggle,grp_led:caps";
      upscaleDefaultCursor = true;
      dpi = 192;
      displayManager = {
        lightdm = {
	 enable = true;
	 greeters.gtk = {
	   enable = true;
	   };
	 };
      };
      windowManager = {
        bspwm = {
	  enable = true;
	};
      };
    };

    # power profiles
    tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC="powersave";
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      START_CHARGE_THRESH_BAT0=0;
      STOP_CHARGE_THRESH_BAT0=80;
      USB_AUTOSUSPEND=0;
      RUNTIME_PM_ON_AC="auto";
     };
   };
  };


  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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

