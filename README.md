<div align="center">

# ❄️ nixos-config

**Ethan's personal NixOS configuration**

[![NixOS](https://img.shields.io/badge/NixOS-25.11-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-blue?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Home Manager](https://img.shields.io/badge/Home%20Manager-25.11-8ebae5?style=for-the-badge)](https://github.com/nix-community/home-manager)

</div>

---

## 🖥️ Hosts

| Host | Device | Kernel | DE | GPU |
|------|--------|--------|----|-----|
| `desktop` | Desktop PC | linux-zen | GNOME | NVIDIA (open) |
| `thinkpad` | ThinkPad | linux 6.18 | GNOME | — |

---

## 📁 Structure

```
.
├── flake.nix                        # Flake inputs & outputs
├── configuration.nix                # Shared system configuration
├── devices/
│   ├── desktop.nix                  # Desktop-specific config
│   └── thinkpad.nix                 # ThinkPad-specific config
└── modules/
    ├── dev-tools.nix                # Development environment
    ├── gaming.nix                   # Steam, launchers, etc.
    ├── haxxing.nix                  # Security & RE tools
    ├── home-manager.nix             # User environment
    ├── locale.nix                   # Timezone & locale
    ├── nix-ld.nix                   # Binary compatibility
    ├── wireguard.nix                # VPN
    └── desktop-environments/
        ├── gnome.nix                # GNOME (active)
        └── hyprland.nix             # Hyprland (alternative)
```

---

## ✨ Features

- **Modular** — shared config with per-device overrides
- **Flakes** — reproducible, pinned inputs
- **Home Manager** — declarative user environment
- **PipeWire** — low-latency audio
- **WireGuard** — VPN via encrypted secrets
- **Nix-LD** — run pre-compiled binaries
- **Automatic GC** — weekly store cleanup, 14-day retention

---

## 🚀 Deploying

Switch the active device symlink then rebuild:

```bash
# Desktop
ln -sf devices/desktop.nix device-configuration.nix
sudo nixos-rebuild switch --flake .#desktop

# ThinkPad
ln -sf devices/thinkpad.nix device-configuration.nix
sudo nixos-rebuild switch --flake .#thinkpad
```

---

## 📦 Notable Packages

| Category | Packages |
|----------|----------|
| **Editors** | Neovim, VSCode |
| **Dev** | Rust, Python, GCC, AVR toolchain, PlatformIO |
| **Gaming** | Steam, Prismlauncher, CKAN |
| **Security** | Wireshark, Ghidra, Aircrack-ng, Metasploit |
| **Desktop** | Firefox, Chrome, Obsidian, Spotify, LibreOffice |

---

## ✅ Todo

- [ ] Migrate ThinkPad to [`nixos-hardware`](https://github.com/NixOS/nixos-hardware) for tuned power management, suspend fixes, and hardware-specific optimizations
- [ ] Switch Docker to rootless mode or migrate to Podman
- [ ] Manage dotfiles (shell, git, neovim) via Home Manager

---

<div align="center">
<sub>Built with ❄️ and too much time on Stack Overflow</sub>
</div>
