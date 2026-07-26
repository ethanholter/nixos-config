{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.mkAfter (with pkgs; [

      # Tools
      acpica-tools
      autoconf 
      automake 
      avra
      avrdude
      cargo
      claude-code
      dig
      distrobox
      ethtool
      fzf
      gcc
      gdb
      gh
      git
      gnumake
      iperf3 
      lazygit
      libtool
      neovim
      nmap
      gtkwave
      platformio
      screen
      tmux
      traceroute
      (pkgs.python3.withPackages (ps: with ps; [
	  pyqt5
      ]))
      pkgs.qt5.qtwayland

      # LSPs
      lua-language-server
      clang-tools

      # Languages / package managers / compilers
      rustc
      python3

  ]);

  home-manager.users.ethan = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };


  # make python less of a pain in the ass
  environment.sessionVariables.QT_QPA_PLATFORM = "wayland";
}
