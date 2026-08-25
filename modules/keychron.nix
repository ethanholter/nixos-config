{ ... }:
{

  services.udev.extraRules = ''
    # Keychron hidraw (Needed for WebUSB access on Chromium browsers)
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", MODE="0660", GROUP="users", TAG+="uaccess"

    # Configure USB (Example)
    SUBSYSTEM=="usb",  ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d049", MODE="0660", GROUP="users", TAG+="uaccess"

    # Configure 2.4GHz (Example)
    SUBSYSTEM=="usb",  ATTRS{idVendor}=="3434", ATTRS{idProduct}=="d028", MODE="0660", GROUP="users", TAG+="uaccess"
  '';
}
