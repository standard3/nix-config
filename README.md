<div align="left">
    <img align="left" src="/assets/github/nixos-logo.png" width="auto">
    &nbsp;
    <h1>nix-config</h1>
    <p>
        My personnal NixOS configuration based on [Gruvbox](https://github.com/morhetz/gruvbox) and [Hyprland](https://hyprland.org/)
    </p>
</div>

> [!Note]
> - Hyprland ecosystem (hyprlock, hypridle, hyprpaper)
> - Home-manager modules
> - Full gruvbox theme
> - ❄️ Flake compliant

## 🖥️ Usage

On NixOS :
```bash
$ sudo nixos-rebuild switch --flake github:standard3/nix-config#jupiter
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
