{ pkgs, ... }:

{
  programs.hyprlock.enable = true;
  programs.hyprland.enable = true; # enable Hyprland
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    # ... other packages
    kitty # required for the default Hyprland config
    rofi
    reversal-icon-theme
    nautilus
    bibata-cursors
    hyprpaper
    brightnessctl
    playerctl
  ];

  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; # prevents overriding
      settings = {
        "org/gnome/desktop/interface" = {
          cursor-theme = "Bibata-Modern-Ice";
        };
      };
    }
  ];

  home-manager.users.ethan = { config, ... }: {
    xdg.configFile."hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/hyprland";
      force = true;
    };
    xdg.configFile."rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/.config/rofi";
      force = true;
    };
  };
}
