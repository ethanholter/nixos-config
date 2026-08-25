{ pkgs, lib, ... }:

{

  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      reversal-icon-theme
      bibata-cursors
    ]
  );
}
