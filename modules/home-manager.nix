{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];
  
      # home manager
  home-manager.users.ethan = { pkgs, ... }: {
      home.packages = [ ];
      # custom desktop entries
      xdg.desktopEntries = {
        nix-packages = {
          name = "Nix Packages";
          genericName = "App Store";
          exec = "firefox https://search.nixos.org/packages";
          terminal = false;
          icon = "nix-software-center";
        };
      };

      home.stateVersion = "25.11";
    };
}