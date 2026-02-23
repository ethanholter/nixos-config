{ pkgs, lib, ... }:
{
    environment.systemPackages = lib.mkAfter (with pkgs; [
        wireshark
        imhex
        aircrack-ng
    ]);

    programs.ghidra.enable = true;
}
