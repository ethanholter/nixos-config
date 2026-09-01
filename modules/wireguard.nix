{ pkgs, lib, ... }:
{
  networking.wg-quick.interfaces."wg0".configFile = "/etc/nixos/secret/wg0.conf";
  
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
        wireguard-tools
    ]
  );
}
