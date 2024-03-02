{ pkgs, ... }:

{
  home.file = let
    defaultWallpaper = ../../../../assets/wallpapers/sea.png;
    wallpaperPath = ".config/hypr/default.png";
  in {
    ".config/hypr/hyprpaper.conf".text = ''
      preload   = ~/${wallpaperPath}
      wallpaper = , ~/${wallpaperPath}
      splash = true
      ipc = off
    '';

    "${wallpaperPath}".source = defaultWallpaper;
  };

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprland wallpaper daemon";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.unstable.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
