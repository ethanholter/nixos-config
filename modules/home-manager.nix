{ pkgs, config, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];
  
      # home manager
  home-manager.users.ethan = { pkgs, ... }: {
      home.file.".local/share/icons/hicolor/256x256/apps/claude.png".source = /etc/nixos/assets/icons/claude.png;
      home.packages = [ ];
      # custom desktop entries
      xdg.desktopEntries = {
        nix-packages = {
          name = "Nix Packages";
          genericName = "App Store";
          exec = "chromium --window-size=1200,900 --app=https://search.nixos.org/packages";
          terminal = false;
          icon = "nix-software-center";
        };
        claude = {
          name = "Claude";
          genericName = "LLM";
          exec = "chromium --window-size=1200,900 --class=claude --app=https://claude.ai";
          terminal = false;
          icon = "claude";
	  settings = {
	      StartupWMClass="claude";
	  };
        };
      };

      home.stateVersion = "25.11";
    };
}
