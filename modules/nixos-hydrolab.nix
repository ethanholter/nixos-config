# Add this to your NixOS configuration.nix (or import it)
# Routes hydrolab-pro.com to localhost via /etc/hosts + nginx reverse proxy

{ config, pkgs, ... }:

{
  # Map hydrolab-pro.com to localhost
  networking.extraHosts = ''
    127.0.0.1 hydrolab-pro.com
  '';

  # Nginx reverse proxy
  services.nginx = {
    enable = true;
    virtualHosts."hydrolab-pro.com" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:5173";
        proxyWebsockets = true;  # needed for Vite HMR
      };
    };
  };

  # Open port 80 in firewall (if enabled)
  networking.firewall.allowedTCPPorts = [ 80 ];
}
