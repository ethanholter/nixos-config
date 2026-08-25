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

  # Defines nixos version used for initial installation
  system.stateVersion = "25.05"; # DO NOT CHANGE
}
