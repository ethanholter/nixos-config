{ lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./device-configuration.nix
    ];

    boot.kernel.sysctl = {
      "net.core.default_qdisc" = "fq"; # Required for BBR
      "net.ipv4.tcp_congestion_control" = "bbr";
    };


    # https://github.com/NixOS/nixpkgs/issues/149812
    environment.extraInit = ''
	export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
	'';

    # Networking
    networking.hostName = "nixos";
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
    #
    # nix = {
    #   package = pkgs.nixFlakes;
    #   extraOptions = ''
    #     experimental-features = nix-command flakes'';
    # };


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
	    wireplumber.enable = true;
	};

	# DNS
	avahi.enable = true;
	resolved.enable = true;
	#services.resolved.dnssec = "true";
    };

    services.fwupd.enable = true;

    nix.settings.allowed-users = [ "ethan" ];

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
    # virtualisation.virtualbox.host.enable = true;
    
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
      brightnessctl
      coreutils-full
      progress
      drawio
      efibootmgr
      firefox
      fzf
      google-chrome
      obsidian
      steam-run
      gparted
      ffmpeg
      iverilog
      metasploit
      brightnessctl
      arduino-ide
      fwupd
      ripgrep
      efibootmgr
      home-manager
      firefox
      liblc3
      gtk3
      htop
      drawio
      inetutils
      iverilog
      libreoffice
      lshw
      sticky
      gtk3
      pavucontrol
      metasploit
      nix-index
      os-prober
      pavucontrol
      pciutils
      ripgrep
      rustc
      spotify
      teams-for-linux
      ripgrep
      chromium
      thunderbird
      nix-index
      thunderbird
      tmux
      tree
      wget
      vim
      wineWowPackages.stable
      xclip
    ]);

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  }
