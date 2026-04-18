{ pkgs, config, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # home manager
  home-manager.users.ethan = { pkgs, ... }: {
      home.packages = [ ];
      home.file.".local/share/icons/hicolor/256x256/apps/claude.png".source = ../assets/icons/claude.png;
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
