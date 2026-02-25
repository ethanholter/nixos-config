{ pkgs, lib, ... }:
{
    programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      arduino-core-unwrapped.out
      krb5.lib
      dbus.lib
      nspr.out
      nss.out
      at-spi2-atk.out
      cups.lib
      cairo.out
      gtk3.out
      pango.out
      # libXdamage.out
      # libXext.out
      # libXfixes.out
      # libXrandr.out
      kdePackages.wayland.out
      libgbm.out
      expat.out
      libxcb.out
      alsa-lib.out
      fontconfig.lib
      freetype.out
      glib.out
      libGL.out
      libgcc.lib
      libxkbcommon.out
      xorg.libX11
    ];
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    libxcomposite
  ]);

}
