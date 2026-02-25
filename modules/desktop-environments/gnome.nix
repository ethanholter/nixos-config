{ lib, pkgs, ... }: 

{
    # xserver
    services.xserver.enable = true;
    services.xserver.excludePackages = [ pkgs.xterm ];

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (with pkgs; [
      decibels
      epiphany
      geary
      gnome-connections
      gnome-music
      gnome-tour
      gnome-user-docs
    ]);

    environment.systemPackages = lib.mkAfter (with pkgs; [
      gnome-tweaks
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-dock
      gnomeExtensions.blur-my-shell
      reversal-icon-theme
      bibata-cursors
      dconf-editor
    ]);

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true; # prevents overriding
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
          };
          "org/gnome/desktop/interface/clock-format" = {
            clock-format = "12h";
          };
          "org/gnome/desktop/interface" = {
            icon-theme = "Reversal";
          };
          "org/gnome/desktop/interface" = {
            cursor-theme = "Bibata-Modern-Ice";
          };
          "org/gnome/desktop/interface" = {
            enable-hot-corners = false;
          };
          "org/gnome/desktop/notifications" = {
            show-in-lock-screen = false;
          };
          "org/gnome/desktop/background" = {
            picture-uri = "file:///etc/nixos/assets/wallpapers/wallpaper1.png";
            picture-uri-dark = "file:///etc/nixos/assets/wallpapers/wallpaper1.png";
          };
        };
      }
    ];
}
