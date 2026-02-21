{ lib, pkgs, ... }:

{
    imports = [
    /etc/nixos/modules/desktop-environments/gnome.nix
    /etc/nixos/modules/dev-tools.nix
    /etc/nixos/modules/gaming.nix
    /etc/nixos/modules/haxxing.nix
    /etc/nixos/modules/home-manager.nix
    /etc/nixos/modules/nix-ld.nix
];
    boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];

# Device Packages
    environment.systemPackages = lib.mkAfter (with pkgs; [
            discord
            distrobox
            docker
            prismlauncher
            neofetch
            qemu
            os-prober
    ]);

# https://discourse.nixos.org/t/gnome-gdm-glitches-after-suspending-sleep/52410/26
# https://discourse.nixos.org/t/suspend-resume-broken-after-24-11-update/56906/17
    boot.kernelParams = lib.mkAfter ([
            "mem_sleep_default=s2idle"
    ]);
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;  # see the note above

        boot.loader = {
            efi.canTouchEfiVariables = true;
            efi.efiSysMountPoint = "/boot/efi";
            grub.efiSupport = true;
            grub.enable = true;
            grub.device = "nodev";
            grub.useOSProber = true;
        };

    system.stateVersion = "25.11";
}
