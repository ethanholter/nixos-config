#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (use sudo)" >&2
    exit 1
fi

echo "Adding NixOS 25.11 stable channel..."
nix-channel --add https://nixos.org/channels/nixos-25.11 nixos

echo "Adding home-manager 25.11 channel..."
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager

echo "Updating channels..."
nix-channel --update

echo "Channels configured successfully:"
nix-channel --list
