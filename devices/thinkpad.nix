{
  lib,
  pkgs,
  config,
  ...
}:

{
  imports = [
  ];

  networking.hostName = "thinkpad";

  # linuxPackages_6_16
  boot.kernelPackages = pkgs.linuxPackages_6_18;
  # boot.kernelPackages = pkgs.linuxPackages_zen;

  # hibernate (write system state to swap storage and power off)
  powerManagement.enable = true;
  services.logind.settings.Login.HandleLidSwitch = "hibernate";
  boot.resumeDevice = "/dev/disk/by-uuid/4be1e673-6ca7-41a0-afce-beb8b0a46e55";
  boot.kernelParams = [ "resume_offset=53999616" ];
  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024;
    }
  ];

  # Defines nixos version used for initial installation
  system.stateVersion = "25.05"; # DO NOT CHANGE
}
