{ lib, pkgs, ... }:

{
  imports = [
    /etc/nixos/modules/desktop-environments/gnome.nix
    /etc/nixos/modules/gaming.nix
  ];
  boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];


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
