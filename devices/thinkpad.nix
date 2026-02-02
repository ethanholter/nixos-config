{ lib, pkgs, ... }:

{
  boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];

  swapDevices = [ {
    device = "/swapfile";
    size = 16*1024;
  } ];

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

    # Power off on lid close instead of sleep. This is ThinkPad specific
    services.logind.settings.Login.HandleLidSwitch = "hibernate";

    # Device Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
      discord
      distrobox
      docker
      prismlauncher
      neofetch
      qemu
    ]);

    programs.steam = {
      enable = true;
    };

    boot.loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub.efiSupport = true;
      grub.device = "nodev";
      grub.useOSProber = true;
    };

    powerManagement.enable = true;
    boot.resumeDevice = "/dev/disk/by-uuid/4be1e673-6ca7-41a0-afce-beb8b0a46e55";
    boot.kernelParams = ["resume_offset=53999616"];

    
    # Defines nixos version used for initial installation
    system.stateVersion = "25.05"; # DO NOT CHANGE
  }
