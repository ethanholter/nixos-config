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
	  ./devices/hardware-desktop.nix
          ./devices/desktop.nix
	  ./modules/desktop-environments/gnome.nix
	  ./modules/dev-tools.nix
	  ./modules/gaming.nix
	  ./modules/haxxing.nix
	  ./modules/home-manager.nix
	  ./modules/locale.nix
	  ./modules/nix-ld.nix
	  ./modules/wireguard.nix

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
          ./devices/hardware-thinkpad.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/dev-tools.nix
          ./modules/gaming.nix
          ./modules/haxxing.nix
          ./modules/home-manager.nix
          ./modules/nix-ld.nix
          ./modules/locale.nix
          ./modules/wireguard.nix
          ./modules/nixos-hydrolab.nix

          home-manager.nixosModules.home-manager
          odrive-udev.nixosModules.default
        ];
      };
    };
  };
}
