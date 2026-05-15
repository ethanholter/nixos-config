{ lib, pkgs, unstable, ... }:

{
  imports = [
  ];

    boot.kernel.sysctl = {
      "net.core.default_qdisc" = "fq"; # Required for BBR
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

    xdg.mime.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };

    boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];

    boot.loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub.efiSupport = true;
      grub.enable = true;
      grub.device = "nodev";
      grub.useOSProber = true;
    };

    # https://github.com/NixOS/nixpkgs/issues/149812
    environment.extraInit = ''
	export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
	'';

    # Networking
    networking.networkmanager.enable = true;

    # Allows userspace programs to aquire realtime cpu scheduling (eg PipeWire)
    security.rtkit.enable = true;

    networking.hosts = {
      "142.204.162.111" = [ "eholter.com" ];
    };

    hardware.bluetooth = {
	enable = true;
	powerOnBoot = true;
	settings = {
	    General = {
		Experimental = true;
		ControllerMode="dual";
		KernelExperimental = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e";
	    };
	};
    };
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.allowed-users = [ "ethan" ];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    nix.optimise.automatic = true;

networking.firewall.interfaces.enp1s0 = {
  allowedUDPPorts = [ 67 53 ];
  allowedTCPPorts = [ 53 ];
};
    services = {
	udev.packages = [
	  pkgs.platformio-core
	];

	pulseaudio.enable = false;
	pipewire = {
	    enable = true;
	    alsa.enable = true;
	    alsa.support32Bit = true;
	    pulse.enable = true;
	    wireplumber = {
	      enable = true;
	    };
	};
        keyd = {
            enable = true;
            keyboards = {
                default = {
                    ids = ["*"];
                    settings = {
                        main = {
                            capslock = "noop"; # Disables it
                        };
                    };
                };
            };
        };

	# DNS
	avahi.enable = true;
        avahi.nssmdns4 = true;
	resolved.enable = true;
    };

    services.fwupd.enable = true;

    # Users
    users.users.ethan = {
      isNormalUser = true;
      description = "Ethan Holter";
      extraGroups = [ "networkmanager" "wheel" "docker" "nix" "dialout" "wireshark" "input"];
    };

    # Nix Packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;

    programs.dconf.enable = true;
    programs.npm.enable = true;

    virtualisation.docker.enable = true;

    # flatpak
    services.flatpak.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdg.portal.config.common.default = "gtk";
    xdg.portal.xdgOpenUsePortal = true;
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
      arduino-ide
      brightnessctl
      chromium
      coreutils-full
      discord
      drawio
      unstable.rpi-imager
      gnome-frog
      efibootmgr
      ffmpeg
      firefox
      dnsmasq
      fwupd
      google-chrome
      gparted
      gtk3
      home-manager
      htop
      inetutils
      iverilog
      liblc3
      libreoffice
      lshw
      metasploit
      fastfetch
      nix-index
      obsidian
      os-prober
      pavucontrol
      pciutils
      progress
      tor-browser
      qemu
      ripgrep
      spotify
      steam-run
      sticky
      teams-for-linux
      thunderbird
      tree
      vim
      wget
      wineWowPackages.stable
      xclip
    ]);
    # obsidian.override { electron = pkgs.electron_39; }# https://github.com/NixOS/nixpkgs/issues/505078#issuecomment-4169858220

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  }
