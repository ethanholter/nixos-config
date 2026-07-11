{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.mkAfter (with pkgs; [
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
      logisim-evolution
      neovim
      nmap
      gtkwave
      platformio
      putty
      python3
      rustc
      screen
      tmux
      traceroute
      vscode
      vscode.fhs
      (pkgs.python3.withPackages (ps: with ps; [
	  pyqt5
      ]))
      pkgs.qt5.qtwayland
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
