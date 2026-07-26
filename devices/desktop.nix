{ lib, pkgs, ... }:

{
  imports = [
  ];
  networking.hostName = "desktop";

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # https://discourse.nixos.org/t/gnome-gdm-glitches-after-suspending-sleep/52410/26
  # https://discourse.nixos.org/t/suspend-resume-broken-after-24-11-update/56906/17
  boot.kernelParams = lib.mkAfter ([
    "mem_sleep_default=s2idle"
  ]);
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true; # see the note above

  system.stateVersion = "25.11";
}
