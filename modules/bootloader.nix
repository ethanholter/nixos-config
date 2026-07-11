{ lib, ... }:
{
    boot.initrd.availableKernelModules = lib.mkAfter [ "usb_storage" "sd_mod" ];

    boot.loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub.efiSupport = true;
      grub.enable = true;
      grub.device = "nodev";
      grub.useOSProber = true;
    };

}
