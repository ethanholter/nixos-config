{ pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
      vscode
      platformio
      avra
      avrdude
      neovim
      distrobox
      lazygit
      python3
      nmap
  ]);

}
