{ lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      bibata-cursors
      extest
      steam-devices-udev-rules
    ];
    extest.enable = true; # prevents "allow remote interaction" popup
  };

  hardware.steam-hardware.enable = true; # 054c:0ce6 hidraw uaccess rules

  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      steam-devices-udev-rules
      prismlauncher
      ckan # Kerbal Space Program mod manager
    ]
  );
}
