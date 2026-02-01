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

    # Kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Networking
    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    networking.wg-quick.interfaces = {
    wg0 = {
      address = [ "10.1.1.7" ];
      dns = [ "10.1.1.2" ];
      privateKeyFile = "/etc/wireguard/privatekey";
      peers = [
        {
          publicKey = "+y4BV3PpVHumAVRWJ+OFvugdytsKWhVDlgAI8ztG7nw=";
          allowedIPs = [ "10.1.1.0/24" ];
          endpoint = "170.9.235.19:51820";
        }
      ];
    };
  };

    # xserver
    services.xserver.enable = true;
    services.xserver.excludePackages = [ pkgs.xterm ];

    # Gnome
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (with pkgs; [
      decibels
      epiphany
      geary
      gnome-connections
      gnome-music
      gnome-tour
      gnome-user-docs
    ]);

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
          };
          "org/gnome/desktop/interface/clock-format" = {
            clock-format = "12h";
          };
          "org/gnome/desktop/interface" = {
            icon-theme = "Reversal";
          };
          "org/gnome/desktop/interface" = {
            enable-hot-corners = false;
          };
          "org/gnome/desktop/notifications" = {
            show-in-lock-screen = false;
          };
        };
      }
    ];

    # Allows userspace programs to aquire realtime cpu scheduling (eg PipeWire)
    security.rtkit.enable = true;

    # Users
    users.users.ethan = {
      isNormalUser = true;
      description = "Ethan Holter";
      extraGroups = [ "networkmanager" "wheel" "docker" "nix" ];
    };

    # Nix Packages
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowBroken = true;

    virtualisation.docker.enable = true;

    # Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
      brightnessctl
      dconf-editor
      dig
      fzf
      gh
      git
      gnome-tweaks
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-dock
      htop
      firefox
      inetutils
      lazygit
      lshw
      pciutils
      nmap
      os-prober
      python3
      reversal-icon-theme
      teams-for-linux
      thunderbird
      tmux
      tree
      vim
      vscode
      wget
      xclip
    ]);

    # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    # Defines nixos version used for initial installation
    system.stateVersion = "25.05"; # DO NOT CHANGE
  }
