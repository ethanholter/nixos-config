{ lib, pkgs, ... }:

{
  programs.steam = {
    enable = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    steam-devices-udev-rules
    prismlauncher
  ]);
}

