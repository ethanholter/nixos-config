{ pkgs, ... }:
{

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMonoNL Nerd Font Mono" ];
        serif = [ "JetBrainsMonoNL Nerd Font Propo" ];
        sansSerif = [ "JetBrainsMonoNL Nerd Font Propo" ];
      };
    };
  };
}
