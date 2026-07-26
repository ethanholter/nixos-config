{ lib, pkgs, ... }:

{

  # Allows userspace programs to aquire realtime cpu scheduling (eg PipeWire)
  security.rtkit.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
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
          ids = [ "*" ];
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
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "nix"
      "dialout"
      "wireshark"
      "input"
    ];
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
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      coreutils-full
      efibootmgr
      ffmpeg
      dnsmasq
      fwupd
      zoxide
      gtk3
      home-manager
      htop
      inetutils
      iverilog
      liblc3
      lshw
      metasploit
      fastfetch
      nix-index
      os-prober
      pciutils
      progress
      qemu
      ripgrep
      steam-run
      sticky
      tree
      vim
      wget
      wineWow64Packages.stable
      xclip
    ]
  );
}
