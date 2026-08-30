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
    hyprshot
    brightnessctl
    playerctl
    mako
    libnotify
  ];

  home-manager.users.ethan = { config, ... }: {
    xdg.configFile."hypr" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/configs/hyprland";
      force = true;
    };
    xdg.configFile."rofi" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/configs/rofi";
      force = true;
    };
    xdg.configFile."waybar" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/configs/waybar";
      force = true;
    };
    xdg.configFile."kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/configs/kitty";
      force = true;
    };
  };
}
