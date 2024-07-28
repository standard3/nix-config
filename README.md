<div align="left">
    <img align="left" src="/assets/github/nixos-logo.png" width="150">
    &nbsp;
    <h1>❄️ nix-config</h1>
    <p>
        My personnal NixOS configuration based on <a href="https://github.com/morhetz/gruvbox" target="_blank">Gruvbox</a> color theme and <a href="https://github.com/morhetz/gruvbox" target="_blank">Hyprland</a>
    </p>
    <div align="center">
        <img src="https://img.shields.io/badge/Built with Nix-grey?style=for-the-badge&logo=nixos&color=%23282828">
        <img src="https://img.shields.io/github/commit-activity/m/standard3/nix-config?style=for-the-badge&color=%23282828&labelColor=%23b8bb26">
        <img src="https://img.shields.io/github/stars/standard3/nix-config?style=for-the-badge&color=%23282828&labelColor=%23fabd2f">
    </div>
</div>

This repository contains my NixOS configuration for my personal devices. It is based on the [Nix package manager](https://nixos.org/) and [NixOS](https://nixos.org/).

## 📦 Features

This configuration is divided into two main hosts :

**Jupiter** : my personal laptop, a Tuxedo InfinityBook 14

> [!Note]
> - Compositor : hyprland ecosystem (hyprlock, hypridle, hyprpaper)
> - Theme : gruvbox
> - Shell : fish + zellij
> - Browser : firefox
> - Editor : vscode + neovim
> - Nix : stable 23.11 + unstable overlay

**Sun** : my personal server, a custom build

> [!Note]
> todo

## 🖥️ Usage

On NixOS :
```bash
# Make sure you have Nix 2.4+ installed
$ nix --version
# Opt-in to experimental features
$ export NIX_CONFIG="experimental-features = nix-command flakes"

# Jupiter host is made for a Tuxedo InfinityBook 14
$ sudo nixos-rebuild switch --flake github:standard3/nix-config#jupiter
# Sun host is made for a custom server
$ sudo nixos-rebuild switch --flake github:standard3/nix-config#sun
```

## 📂 Folder logic

The repository is divided into 4 main parts :
- `home` : home-manager environments and applications
- `hosts` : host-specific NixOS configuration and their hardware
- `modules` : additional NixOS or home-manager modules
- `overlays` : generic overlays

## 🧩 Showcase

to-do

## 📌 Credits

Based on [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs) minimal and some bits from other configs.
