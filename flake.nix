{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
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
            ./devices/hardware-desktop.nix
            ./modules/bootloader.nix
            ./modules/desktop-environments/gnome.nix
            ./modules/dev-tools.nix
            ./modules/fonts.nix
            ./modules/gaming.nix
            ./modules/haxxing.nix
            ./modules/home-manager.nix
            ./modules/locale.nix
            ./modules/networking.nix
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
          ./devices/hardware-thinkpad.nix
          ./devices/thinkpad.nix
          ./modules/bootloader.nix
          ./modules/desktop-environments/gnome.nix
          ./modules/dev-tools.nix
          ./modules/fonts.nix
          ./modules/gaming.nix
          ./modules/haxxing.nix
          ./modules/home-manager.nix
          ./modules/locale.nix
          ./modules/networking.nix
          ./modules/nix-ld.nix
          ./modules/nixos-hydrolab.nix
          ./modules/wireguard.nix

          home-manager.nixosModules.home-manager
          odrive-udev.nixosModules.default
        ];
      };
    };
  };
}
