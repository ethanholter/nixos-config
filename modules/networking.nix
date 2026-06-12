{ pkgs, ... }: 
{
    networking.networkmanager.enable = true;

    # fixes issues with ssh via mDNS 
    networking.firewall.interfaces.enp1s0 = {
      allowedUDPPorts = [ 67 53 ];
      allowedTCPPorts = [ 53 ];
    };
    
    # DNS, mDNS
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.resolved.enable = true;

    environment.systemPackages = lib.mkAfter (with pkgs; [
        dnsmasq
    ]);
}
