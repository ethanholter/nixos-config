{ pkgs, ... }:

{
  programs.hyprland.enable = true; # enable Hyprland
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    # ... other packages
    kitty # required for the default Hyprland config
    wofi
    reversal-icon-theme
    nautilus
    bibata-cursors
    hyprpaper
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
      recursive = true;
    };
  };
}
