{ pkgs, lib, ... }:
{
    programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # libXdamage.out
      # libXext.out
      # libXfixes.out
      # libXrandr.out
      alsa-lib.out
      nss.out
      arduino-core-unwrapped.out
      at-spi2-atk.out
      cairo.out
      cups.lib
      dbus.lib
      expat.out
      fontconfig.lib
      freetype.out
      glib.out
      gtk3.out
      kdePackages.wayland.out
      krb5.lib
      libGL.out
      libgbm.out
      libgcc.lib
      libtool.out
      libxcb.out
      libxkbcommon.out
      nspr.out
      pango.out
      xorg.libX11
    ];
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    libxcomposite
  ]);

}
