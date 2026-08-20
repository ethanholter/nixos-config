{... }:
{

  boot.initrd.services.udev.rules = ''
  ACTION=="add", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="0250", RUN+="/run/current-system/sw/bin/keychron-set-key"
  '';
}
