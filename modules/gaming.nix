{ lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [            
        bibata-cursors
      ];
  };
  
  environment.systemPackages = lib.mkAfter (with pkgs; [
    steam-devices-udev-rules
    prismlauncher
  ]);
}

