{ pkgs, lib, ... }:
{
    environment.systemPackages = lib.mkAfter (with pkgs; [
        wireshark
        ghidra-bin
        imhex
        aircrack-ng
    ]);
}