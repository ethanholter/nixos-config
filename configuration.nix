{ lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./device-configuration.nix
    ];

    services.udev.packages = [
      pkgs.platformio-core
      pkgs.openocd
    ];

    services.avahi.enable = true;
    services.resolved.enable = true;

    # Kernel
    # boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelPackages = pkgs.linuxPackages_zen;

    # Networking
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    # Allows userspace programs to aquire realtime cpu scheduling (eg PipeWire)
    security.rtkit.enable = true;

    services.pulseaudio.enable = false;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Users
    users.users.ethan = {
      isNormalUser = true;
      description = "Ethan Holter";
      extraGroups = [ "networkmanager" "wheel" "docker" "nix" "dialout"];
    };

    # Nix Packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;

    virtualisation.docker.enable = true;
    
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

    # Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
      brightnessctl
      dig
      efibootmgr
      firefox
      fzf
      gh
      git
      gparted
      htop
      inetutils
      libreoffice
      lshw
      os-prober
      pciutils
      spotify
      teams-for-linux
      thunderbird
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
