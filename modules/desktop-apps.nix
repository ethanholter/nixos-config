{ lib, pkgs, unstable, ... }:
{
    xdg.mime.defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };

    environment.systemPackages = lib.mkAfter (with pkgs; [
      chromium
      discord
      drawio
      firefox
      google-chrome
      arduino-ide
      logisim-evolution
      gparted
      libreoffice
      obsidian
      pavucontrol
      spotify
      teams-for-linux
      thunderbird
      putty
      tor-browser
      unstable.rpi-imager
    ]);
}
