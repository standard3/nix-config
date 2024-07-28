# Sun

## Applications

- [ ] Configure SSH server
- [ ] MFA Authelia service => see [that](https://www.smarthomebeginner.com/docker-authelia-tutorial/) and [that](https://dizzytech.de/posts/authelia/)
- [ ] Reverse Proxy service (Nginx Proxy Manager + [Goaccess](https://github.com/xavier-hernandez/goaccess-for-nginxproxymanager) or Traefik, or Caddy)
- [ ] VPN service ([Netbird over Wireguard ?](https://github.com/netbirdio/netbird) => https://dizzytech.de/posts/wireguard/, only [Wireguard](https://www.wireguard.com/))
- [ ] DNS service (PiHole ? Adguard ? Blocky ? Technitium ?)
    - [ ] Block ads
- [ ] Dashboard (Dashy ? [Homepage](https://github.com/benphelps/homepage) ?) voir [tuto](https://www.youtube.com/watch?v=z6whWBBYQEY)
		- [ ] + [Icons](https://github.com/walkxcode/Dashboard-Icons)
- [ ] Theming ([theme-park](https://theme-park.dev/))
- [ ] Paperless service ([Paperless-ng]( https://github.com/jonaswinkler/paperless-ng) ? [Papermerge](https://github.com/ciur/papermerge) ? [Paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) ?)
- [ ] Temperature notifier => https://blog.kastanis.gr/simple-server-thermal-warning/ + https://blog.kastanis.gr/gotify-self-hosted-push-notification-server/
- [ ] Cloud service (Nextcloud ([see guide](https://www.reddit.com/r/selfhosted/comments/vf6jeg/i_used_unix_sockets_to_improve_the_performance_of/)) ?)
- [ ] Monitoring service (Grafana ? Dashdot ? [ntopng](https://github.com/ntop/ntopng) ?)
		- [ ] Uptime with Uptime Kuma ? [Fing](https://www.fing.com/) ?
		- [ ] Notify with Gotify to matrix/discord/mail
- [ ] Financial service ([Firefly III](https://www.firefly-iii.org) ? [Actual](https://github.com/actualbudget/actual) ? https://homechart.app)
- [ ] Easy picture / video sharing service ([Lychee](https://lycheeorg.github.io/lychee/) ? Fireshare ?)
- [ ] Backup service (Duplicati ?)


**Media services**

- [ ] Torrent service ([Flood](https://flood.js.org/) + qBittorrent ?)

See https://perfectmediaserver.com/ and https://trash-guides.info/

## Utilities

- [ ] btop
- [ ] fish
- [ ] zellij
- [ ] Setup useful motd

## Security

- [ ] Harden server configuration (see [hacktricks](https://book.hacktricks.xyz/linux-hardening/linux-privilege-escalation-checklist), maybe take a look at [noted.lol](https://noted.lol))
- [ ] [Crowdsec](https://www.crowdsec.net/) or [fail2ban](https://github.com/fail2ban/fail2ban)
- [ ] Setup firewall

# Jupiter

## Applications

- [x] Add a notification manager => see [SwayNotificationCente](https://github.com/ErikReider/SwayNotificationCenter) and https://github.com/zDyanTB/HyprNova
  - [ ] Finish configuration
- [x] Add Yazi file manager
  - [ ] Finish configuration
- [ ] Add Youtube Music
- [ ] Add Obsidian
- [ ] Add VirtualBox
- [ ] Add LibreOffice
- [ ] Add Thunderbird

## Utilities

- [ ] Waybar
    - [ ] Add GPU stats
    - [ ] Add power menu with Nix icon => on anyrun
    - [ ] Fix wireplumber + slider
    - [ ] Add backlight + slider
    - [ ] Add battery
- [ ] Add `setup` wrapper to construct devenv flakes
    - [ ] Python
    - [ ] Rust
    - [ ] C
- [ ] Delete KDE Plasma

## Enhancements

- [ ] Finish configuring wlogout
- [x] Configure ~~way-displays~~ kanshi
    - [x] Handle displays correctly
- [x] Enhance Git configuration
    - [x] Handle personnal and school keys
    - [x] Multiple QoL => see [video](https://www.youtube.com/watch?v=aolI_Rz0ZqY)
- [ ] Rework Firefox styling settings
- [ ] Add a README with features
- [ ] Add `dashlane-cli` and integrate with `add-ssh`
- [ ] Add GitLens to vscode
- [ ] Add .pythonstartup script
