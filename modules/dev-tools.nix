{ pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
      autoconf 
      automake 
      avra
      avrdude
      cargo
      dig
      distrobox
      fzf
      gcc
      gdb
      gh
      git
      gnumake
      lazygit
      libtool
      neovim
      nmap
      platformio
      putty
      python3
      rustc
      tmux
      vscode
  ]);

}
