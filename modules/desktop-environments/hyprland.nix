{ pkgs, ... }:

{

  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.enable = true;
  programs.hyprland.enable = true; # enable Hyprland

  environment.systemPackages = [
    # ... other packages
    pkgs.kitty # required for the default Hyprland config
  ];
}
