{ lib, pkgs, config, ... }:

{
  imports = [
    /etc/nixos/modules/desktop-environments/gnome.nix
    /etc/nixos/modules/dev-tools.nix
    /etc/nixos/modules/gaming.nix
    /etc/nixos/modules/haxxing.nix
    /etc/nixos/modules/nix-ld.nix
    /etc/nixos/modules/locale.nix
    /etc/nixos/modules/wireguard.nix
  ];

  boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];


  # linuxPackages_6_16
  boot.kernelPackages = pkgs.linuxPackages_6_18;
  # boot.kernelPackages = pkgs.linuxPackages_zen;
    # Device Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
      discord
      distrobox
      docker
      neofetch
      qemu
    ]);


    boot.loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub.efiSupport = true;
      grub.device = "nodev";
      grub.useOSProber = true;
    };

    # hibernate (write system state to swap storage and power off)
    powerManagement.enable = true;
    services.logind.settings.Login.HandleLidSwitch = "hibernate";
    boot.resumeDevice = "/dev/disk/by-uuid/4be1e673-6ca7-41a0-afce-beb8b0a46e55";
    boot.kernelParams = ["resume_offset=53999616"];
    swapDevices = [ {
      device = "/swapfile";
      size = 16*1024;
    } ];

    # Defines nixos version used for initial installation
    system.stateVersion = "25.05"; # DO NOT CHANGE
  }
