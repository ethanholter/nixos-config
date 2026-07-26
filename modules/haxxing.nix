{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      wireshark
      imhex
      aircrack-ng
    ]
  );

  programs.ghidra.enable = true;
  programs.wireshark.enable = true;
  programs.wireshark.dumpcap.enable = true;
  programs.wireshark.usbmon.enable = true;
}
