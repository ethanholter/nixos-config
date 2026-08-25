{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    odrive-udev.url = "github:ethanholter/odrive-udev";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      odrive-udev,
      ...
    }:
    let
      unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit unstable; };
          modules = [
            # Configuration
            ./configuration.nix
            ./devices/desktop.nix
            ./devices/hardware-desktop.nix

            # Desktop environment
            ./modules/desktop-environments/gnome.nix
            ./modules/desktop-environments/hyprland.nix
            ./modules/desktop-environments/common.nix
            ./modules/display-managers/gdm.nix

            # Modules
            ./modules/bluetooth.nix
            ./modules/bootloader.nix
            ./modules/desktop-apps.nix
            ./modules/dev-tools.nix
            ./modules/fonts.nix
            ./modules/gaming.nix
            ./modules/haxxing.nix
            ./modules/home-manager.nix
            ./modules/locale.nix
            ./modules/networking.nix
            ./modules/nix-ld.nix
            ./modules/keychron.nix
            # ./modules/wireguard.nix

            # Flakes
            home-manager.nixosModules.home-manager
            # odrive-udev.nixosModules.default
          ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit unstable; };
          modules = [
            ./configuration.nix
            ./devices/hardware-thinkpad.nix
            ./devices/thinkpad.nix

            # Desktop environment
            ./modules/desktop-environments/gnome.nix
            ./modules/desktop-environments/hyprland.nix
            ./modules/desktop-environments/common.nix
            ./modules/display-managers/gdm.nix

            # Modules
            ./modules/bluetooth.nix
            ./modules/bootloader.nix
            ./modules/desktop-apps.nix
            ./modules/dev-tools.nix
            ./modules/fonts.nix
            ./modules/gaming.nix
            ./modules/haxxing.nix
            ./modules/home-manager.nix
            ./modules/locale.nix
            ./modules/networking.nix
            ./modules/nix-ld.nix
            # ./modules/wireguard.nix

            # Flakes
            home-manager.nixosModules.home-manager
            # odrive-udev.nixosModules.default
          ];
        };
      };
    };

  # workaround to use flake.nix (or flake.lock) without commiting to git or having to
  # constantly commit and uncommit
  # https://discourse.nixos.org/t/can-i-use-flakes-within-a-git-repo-without-committing-flake-nix/18196/5

  # git add --intent-to-add flake.nix
  # git update-index --assume-unchanged flake.nix

}
