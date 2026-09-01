{ pkgs, lib, ... }:

{

  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [
      reversal-icon-theme
      bibata-cursors
    ]
  );
  home-manager.users.ethan = { pkgs, lib, ... }: {
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };
    };
  };
}
