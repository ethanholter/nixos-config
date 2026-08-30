{ pkgs, lib, ... }:
{

  # to temporarily disable run:
  # sudo systemctl stop firewall 
  networking.networkmanager.enable = true;

  # fixes issues with ssh via mDNS
  networking.firewall.interfaces.enp1s0 = {
    allowedUDPPorts = [
      67
      53
    ];
    allowedTCPPorts = [ 53 5000 5001 ];
  };

  # DNS, mDNS
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.resolved.enable = true;

  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      dnsmasq
    ]
  );
    
  # override eduroam's fasciast DNS server
  networking.extraHosts = ''
    104.166.250.211 eholter.com
  '';
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq"; # Required for BBR
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
