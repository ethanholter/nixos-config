{ lib, inputs, config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./device-configuration.nix
      (import "${home-manager}/nixos")
    ];

    # home manager
    home-manager.users.ethan = { pkgs, ... }: {
      home.packages = [ ];

      # custom desktop entries
      xdg.desktopEntries = {
        nix-packages = {
          name = "Nix Packages";
          genericName = "App Store";
          exec = "firefox --new-window https://search.nixos.org/packages";
          terminal = false;
          icon = "nix-software-center";
        };
      };

      home.stateVersion = "25.11";
    };

    services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
  ];

  services.avahi.enable = true;
  services.resolved.enable = true;

    programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      arduino-core-unwrapped.out
      libgcc.lib
    ];
  };

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
      dconf-editor
      dig
      distrobox
      firefox
      fzf
      platformio
      gh
      git
      efibootmgr
      htop
      inetutils
      lazygit
      libreoffice
      lshw
      nmap
      os-prober
      pciutils
      python3
      aircrack-ng
      wireshark
      teams-for-linux
      thunderbird
      tmux
      gparted
      tree
      vim
      spotify
      vscode
      wget
      xclip
    ]);

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  }
