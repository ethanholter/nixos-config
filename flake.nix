{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    odrive-udev.url = "github:ethanholter/odrive-udev";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, odrive-udev, ... }: let
    unstable = import nixpkgs-unstable { system = "x86_64-linux"; config.allowUnfree = true; };
  in {
    nixosConfigurations = {

      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit unstable; };
        modules = [
          ./configuration.nix
          ./devices/desktop.nix
          # TODO put module imports here instead of desktop.nix
          home-manager.nixosModules.home-manager
          odrive-udev.nixosModules.default
        ];
      };

      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit unstable; };
        modules = [
          ./configuration.nix
          ./devices/thinkpad.nix
          # TODO put module imports here instead of thinkpad.nix
          home-manager.nixosModules.home-manager
          odrive-udev.nixosModules.default
        ];
      };
    };
  };
}
