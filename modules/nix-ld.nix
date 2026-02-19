{ pkgs, ... }:
{
    programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      arduino-core-unwrapped.out
      libgcc.lib
    ];
  };
}