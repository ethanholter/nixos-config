{ pkgs, ... }:
let
  customized_sddm_astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "astronaut"; # The name of the theme you most loved
    # themeConfig = {
    #   Background = "path/to/background.jpg"; # This theme also accepts videos
    # };
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = [
      customized_sddm_astronaut # change the name of the package here to the one you created
    ];

    theme = "sddm-astronaut-theme"; # This remains the same because is the name of the theme, not the package
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme"; # Remains the same
      };
    };
  };
}
