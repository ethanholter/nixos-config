{ lib, pkgs, ... }:

{
    boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];

    # Device Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
            discord
            distrobox
            docker
            steam
            prismlauncher
            neofetch
            qemu
	    os-prober
    ]);

    boot.loader = {
	efi.efiSysMountPoint = "/boot";
	grub.efiSupport = true;
        grub.device = "nodev";
        grub.useOSProber = true;
    };

    system.stateVersion = "25.11";
}
