{ ... }:
{
    networking.wg-quick.interfaces."wg0".configFile = "/etc/nixos/secret/wg0.conf";
}
