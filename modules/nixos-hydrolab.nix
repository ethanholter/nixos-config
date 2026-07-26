# Almost entirely vibecoded configuration for use in IoT project "Hydrolab Pro Grow" in spring 2026.
# sets up a bunch of various services required for the project running locally for the demo.
# also sets up some self-signed certs and fake domains because we were being kinda sneaky for the demo.
# (we never hosted anything on the internet, just pretended to with local stuff)

# Routes hydrolab-pro.com and grafana.hydrolab-pro.com to localhost via nginx + self-signed TLS

{ pkgs, ... }:

{
  # Map domains to localhost
  networking.extraHosts = ''
    127.0.0.1 hydrolab-pro.com
    127.0.0.1 grafana.hydrolab-pro.com
  '';

  # Grafana
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        domain = "grafana.hydrolab-pro.com";
        root_url = "https://grafana.hydrolab-pro.com";
      };
      # Skip login for the demo
      "auth.anonymous" = {
        enabled = true;
        org_role = "Admin";
      };
    };
    provision.datasources.settings.datasources = [
      {
        name = "InfluxDB";
        type = "influxdb";
        access = "proxy";
        url = "YOUR_INFLUXDB_URL";
        jsonData = {
          version = "Flux";
          organization = "YOUR_INFLUXDB_ORG";
          defaultBucket = "hydrolab";
        };
        secureJsonData = {
          token = "YOUR_INFLUXDB_TOKEN";
        };
      }
    ];
  };

  # Nginx reverse proxy
  services.nginx = {
    enable = true;

    virtualHosts."hydrolab-pro.com" = {
      forceSSL = true;
      sslCertificate = "/etc/ssl/hydrolab-pro.com.crt";
      sslCertificateKey = "/etc/ssl/hydrolab-pro.com.key";
      locations."/" = {
        proxyPass = "http://localhost:5173";
        proxyWebsockets = true;
      };
    };

    virtualHosts."grafana.hydrolab-pro.com" = {
      forceSSL = true;
      sslCertificate = "/etc/ssl/hydrolab-pro.com.crt";
      sslCertificateKey = "/etc/ssl/hydrolab-pro.com.key";
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };
  };

  # Generate self-signed cert (covers both domains via SAN)
  system.activationScripts.hydrolab-selfsigned-cert = ''
    if [ ! -f /etc/ssl/hydrolab-pro.com.crt ]; then
      ${pkgs.openssl}/bin/openssl req -x509 -newkey rsa:2048 \
        -keyout /etc/ssl/hydrolab-pro.com.key \
        -out /etc/ssl/hydrolab-pro.com.crt \
        -days 365 -nodes \
        -subj "/CN=hydrolab-pro.com" \
        -addext "subjectAltName=DNS:hydrolab-pro.com,DNS:grafana.hydrolab-pro.com"
      chmod 640 /etc/ssl/hydrolab-pro.com.key
      chown root:nginx /etc/ssl/hydrolab-pro.com.key
    fi
  '';

  # Open ports 80 (redirect) and 443 (HTTPS)
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
