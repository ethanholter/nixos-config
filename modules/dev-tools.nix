{ pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
      vscode
      platformio
      neovim
      distrobox
      lazygit
      python3
      nmap
  ]);

}