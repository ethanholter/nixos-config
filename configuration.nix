{ lib, pkgs, unstable, ... }:

{
    xdg.mime.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };

    # Allows userspace programs to aquire realtime cpu scheduling (eg PipeWire)
    security.rtkit.enable = true;

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

    # distrobox-create -i ubuntu:24.04 -n ubuntu -H /home/ubuntu -r -p -I
    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;


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
      zoxide
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
      wineWow64Packages.stable
      xclip
    ]);

  }
