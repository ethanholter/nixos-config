{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/luks-1dcb43dc-3311-482e-aea7-723c679c3dbc";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-1dcb43dc-3311-482e-aea7-723c679c3dbc".device = "/dev/disk/by-uuid/1dcb43dc-3311-482e-aea7-723c679c3dbc";
  boot.initrd.luks.devices."luks-8a157132-575d-4daf-a4ca-2d54b400c733".device = "/dev/disk/by-uuid/8a157132-575d-4daf-a4ca-2d54b400c733";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/655B-5A2C";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/mapper/luks-8a157132-575d-4daf-a4ca-2d54b400c733"; }
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
