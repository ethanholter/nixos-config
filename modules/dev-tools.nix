{ pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
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
      traceroute
      acpica-tools
      git
      gnumake
      iperf3 
      lazygit
      logisim-evolution
      libtool
      neovim
      nmap
      platformio
      putty
      python3
      rustc
      tmux
      vscode
      (pkgs.python3.withPackages (ps: with ps; [
	  matplotlib
	  pyqt5
      ]))
      pkgs.qt5.qtwayland
  ]);

  # make python less of a pain in the ass
  environment.sessionVariables.QT_QPA_PLATFORM = "wayland";
}
