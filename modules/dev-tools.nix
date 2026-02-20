{ pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
      vscode
      platformio
      putty
      avra
      avrdude
      neovim
      distrobox
      lazygit
      python3
      nmap
  ]);

}
