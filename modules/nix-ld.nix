{ pkgs, ... }:
{
    programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      arduino-core-unwrapped.out
      krb5.lib
      dbus.lib
      fontconfig.lib
      freetype.out
      glib.out
      libGL.out
      libgcc.lib
      libxkbcommon.out
      xorg.libX11
    ];
  };
}
