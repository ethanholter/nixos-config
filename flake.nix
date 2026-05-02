{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    odrive-udev.url = "github:ethanholter/odrive-udev";
  };

  outputs = { self, nixpkgs, home-manager, odrive-udev, ... }: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./devices/desktop.nix
          home-manager.nixosModules.home-manager
          odrive-udev.nixosModules.default
        ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./devices/thinkpad.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
