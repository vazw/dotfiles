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
    boot = {
      kernelParams = [
	"button.lid_init_state=open"
      ];
      loader = {
        timeout = 1;
	grub = {
	  enable = true;
	  devices = ["nodev"];
	  efiSupport = true;
	  # useOSProber = true;
	};
      };
    };

  networking = {
    useDHCP = lib.mkDefault false;
    hostName = "nixos";
    # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    nameservers = [
      "1.1.1.1"
      "9.9.9.9"
    ];
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
    pam.services.vaz.enableGnomeKeyring = true;
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
      picom
      xorg.xdpyinfo
      xorg.libX11
      xtitle
      xautolock
      (rofi.override {plugins=[rofi-emoji];})
      xclip
      ranger 
      brillo
      networkmanagerapplet
      wmname
      scrot
      betterlockscreen
      helix

      pavucontrol
      tlp		# Power Management
      blueberry		# Bluetooth GUI
      pamixer
      nodejs_20		# Node for LSP
      python311Full
      python311Packages.virtualenv
      keepassxc   	# Offline Saved Passwords
      blender
      xdg-utils
      dconf
      starship
      xfce.thunar
      xdg-user-dirs
      btop
      mpd
      mpc-cli
      tmux
      firefox
      gtk-engine-murrine
      gtk_engines
      cmake
      unzip             # Zip Files
      unrar             # Rar Files
      zip               # Zip
      # Video/Audio
      feh               # Image Viewer
      mpv               # Media Player
      vlc               # Media Player
      dunst 		# Notification
      gnome.adwaita-icon-theme
      kitty
      qrencode
      microsoft-edge

      # Apps
      appimage-run      # Runs AppImages on NixOS
      remmina           # XRDP & VNC Client
      obs-studio
      telegram-desktop
      lazygit # Git Terminal Ui
      gtk3
      mongodb-compass
      mysql-workbench

      gnome.file-roller # Archive Manager
      gimp
      okular            # PDF Viewer
      libreoffice-still # OfficeSuit
      p7zip             # Zip Encryption
      (catppuccin-gtk.override {
        accents = ["green"];
        size = "compact";
	tweaks = ["rimless"];
        variant = "mocha";
      })
      qbittorrent
      lxappearance
      ueberzug
      (catppuccin-papirus-folders.override {
        flavor = "mocha";
	accent = "green";
	})
      nil # nix language server

    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment = {
     sessionVariables = {
       QT_AUTO_SCREEN_SET_FACTOR=1;
       GDK_DPI_SCALE=0.8;
       QT_QPA_PLATFORMTHEME="qt5ct";
       QT_SCALE_FACTOR=1;
       QT_FONT_DPI=170;
     };
     systemPackages = with pkgs; [
       neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
       wget
       git
       fish
       gcc
       zig
       exa
       ta-lib
       tree
       jq
       glib
       curl
       acpi
       acpid

       man
       docker-compose
       virt-manager
       qemu_kvm
       upower
       shared-mime-info
       pcmanfm
       killall
       xsettingsd
       #lib
       libvirt
       libguestfs
       libsecret
       libthai
       libnotify
       rsync             # Syncer - $ rsync -r dir1/ dir2/
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
    sleep.extraConfig = ''
      AllowSuspend=yes
      AllowHibernation=yes
      AllowSuspendThenHibernate=yes 
      AllowHybridSleep=yes 
      SuspendMode=suspend 
      HibernateMode=shutdown
      HybridSleepMode=suspend  
      SuspendState=mem 
      HibernateState=disk 
      HybridSleepState=disk
      HibernateDelaySec=2h
      SuspendEstimationSec=1h
    '';
  # services = {
  #  };
  # NOT WORKING
  user.services = {
    betterlockscreen = {
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
  # tmux = {
  #    description = "tmux default session (detached)";
  #    environment = { DISPLAY=":0";};
  #    serviceConfig = {
  #      Type = "forking";
  #      ExecStart = ''
  #        ${pkgs.tmux}/bin/tmux new-session -d
  #        '';
  #      ExecStop=''
  #        /home/vaz/.config/tmux/plugins/tmux-resurrect/scripts/save.sh
  #        ${pkgs.tmux}/bin/tmux kill-server
  #        '';
  #      KillMode="control-group";
  #      RestartSec = 2;
  #      };
  #    wantedBy = [ "default.target"];
  #   };
    };
  };

  services = {
    # printing.enable = true;
    openssh.enable = true;
    upower.enable = true;
    dbus.enable = true;
    mpd.enable = true;
    gvfs.enable = true;
    logind = {
      lidSwitchExternalPower = "suspend-then-hibernate";
      lidSwitchDocked = "ignore";
      lidSwitch = "suspend-then-hibernate";
      extraConfig = ''
        IdleAction=lock
        HandlePowerKey=hybrid-sleep
      '';
    };
    xserver = {
      enable = true;
      libinput = {
        enable = true;
	touchpad = { 
	  naturalScrolling = true;
	  accelSpeed = "0.5";
	  disableWhileTyping = true;
	  };
	};
      layout = "us,th";
      xkbOptions = "grp:caps_toggle,grp_led:caps";
      upscaleDefaultCursor = true;
      dpi = 170; # Defualt Resolution for Asus Zenbook 13 is 255
      displayManager = {
        lightdm = {
	 enable = true;
	 };
      };
      windowManager = {
        bspwm = {
	  enable = true;
	};
      };
      xautolock = {
        enable = true;
        locker = ''${pkgs.betterlockscreen}/bin/betterlockscreen --lock'';
        time = 15;
	extraOptions = [ "-detectsleep" "-lockaftersleep"];
	notifier = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds'";
	};
      config = ''
         Section "Extensions"
             Option "DPMS" "off"
         EndSection
      '';
    };

    # power profiles
    tlp = {
      enable = true;
      settings = {
        # CPU_SCALING_GOVERNOR_ON_AC="performance";
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

