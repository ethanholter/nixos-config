{ lib, pkgs, ... }:

{
    boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];

    swapDevices = [ {
        device = "/swapfile";
        size = 16*1024;
    } ];

    # Power off on lid close instead of sleep. This is ThinkPad specific
    services.logind.settings.Login.HandleLidSwitch = "hibernate";

    # Device Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
            discord
            distrobox
            docker
            steam
            prismlauncher
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

    powerManagement.enable = true;
    boot.resumeDevice = "/dev/disk/by-uuid/4be1e673-6ca7-41a0-afce-beb8b0a46e55";
    boot.kernelParams = ["resume_offset=53999616"];
}
