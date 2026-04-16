{ lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [            
        bibata-cursors
	extest
      ];
    extest.enable = true; # prevents "allow remote interaction" popup
  };
  
  environment.systemPackages = lib.mkAfter (with pkgs; [
    steam-devices-udev-rules
    prismlauncher
    ckan # Kerbal Space Program mod manager
  ]);
}

