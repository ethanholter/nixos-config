{ lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./device-configuration.nix
    ];


    # https://github.com/NixOS/nixpkgs/issues/149812
    environment.extraInit = ''
	export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
	'';


    # Kernel
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelPackages = pkgs.linuxPackages_zen;

    # Networking
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    # Allows userspace programs to aquire realtime cpu scheduling (eg PipeWire)
    security.rtkit.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
	General = {
	    Experimental = true;
	    ControllerMode="dual";
	    KernelExperimental = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e";
	};
    };

    services = {
	udev.packages = [
	  pkgs.platformio-core
	  pkgs.openocd
	];

	pulseaudio.enable = false;
	pipewire = {
	    enable = true;
	    alsa.enable = true;
	    alsa.support32Bit = true;
	    pulse.enable = true;
	    wireplumber.enable = true;
	#     wireplumber.extraConfig."10-bluez"  = {
	# 	"monitor.bluez.properties" = {
	# 	    "bluez5.codecs" = [ "sbc" "sbc_xq" "aac" "lc3" ];
	#
	# 	};
	#     };

	};

	# DNS
	avahi.enable = true;
	resolved.enable = true;

    };


    # Users
    users.users.ethan = {
      isNormalUser = true;
      description = "Ethan Holter";
      extraGroups = [ "networkmanager" "wheel" "docker" "nix" "dialout" "plugdev"];
    };

    # Nix Packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;

    programs.dconf.enable = true;
    programs.npm.enable = true;

    virtualisation.docker.enable = true;
    virtualisation.virtualbox.host.enable = true;
    
    # flatpak
    services.flatpak.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdg.portal.config.common.default = "gtk";
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };

    programs.command-not-found.enable = false;
    programs.bash.interactiveShellInit = ''
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';


    # Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
      brightnessctl
      dig
      efibootmgr
      google-chrome
      firefox
      cargo
      rustc
      fzf
      tmux
      gh
      git
      gdb
      gparted
      iverilog
      metasploit
      htop
      quartus-prime-lite
      drawio
      gcc
      inetutils
      libreoffice
      lshw
      gtk3
      pavucontrol
      os-prober
      pciutils
      wineWowPackages.stable
      spotify
      teams-for-linux
      thunderbird
      toybox
      nix-index
      tree
      vim
      wget
      xclip
    ]);

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  }
