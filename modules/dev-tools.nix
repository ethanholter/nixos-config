{ pkgs, lib, ... }:
{
  environment.systemPackages = lib.mkAfter (
    with pkgs;
    [

      # Tools
      acpica-tools
      autoconf
      automake
      claude-code
      dig
      distrobox
      ethtool
      fzf
      gh
      git
      gnumake
      gtkwave
      iperf3
      lazygit
      libtool
      neovim
      nmap
      pkgs.qt5.qtwayland
      platformio
      screen
      tmux
      traceroute

      # Languages
      avra
      avrdude
      cargo
      gcc
      gdb
      python3
      rustc
      jdk25

      # Language development tools
      basedpyright
      clang-tools
      lua-language-server
      nixd
      ruff
      nixfmt

    ]
  );

  home-manager.users.ethan = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
  };

  # make python less of a pain in the ass
  environment.sessionVariables.QT_QPA_PLATFORM = "wayland";
}
