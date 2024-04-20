{ inputs, ... }:

# TODO: watch for plasma6 in stable and install https://github.com/zeroxoneafour/polonium

let
  defaultWallpaper = ../../../../assets/wallpapers/sea.png;
  wallpaperPath = ".config/wallpapers/default.png";
in
{
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  home.file."${wallpaperPath}".source = defaultWallpaper;

  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      # cursorTheme = "Bibata-Modern-Ice";
      # iconTheme = "Papirus-Dark";
      # wallpaper = wallpaperPath;
    };

    shortcuts = {
      # Alacritty
      "Alacritty.desktop"."New" = [ ];
      "Alacritty.desktop"."_launch" = "Meta+Return";

      # KRunner
      "org.kde.krunner.desktop"."_launch" = "Meta+Space";

      kwin = {
        # Actions
        "Window Close" = "Meta+Q";

        # Switch to desktop
        "Switch to Desktop 1" = "Meta+&";
        "Switch to Desktop 2" = "Meta+É";
        "Switch to Desktop 3" = "Meta+\"";
        "Switch to Desktop 4" = "Meta+'";
        "Switch to Desktop 5" = "Meta+(";
        "Switch to Desktop 6" = [ ];
        "Switch to Desktop 7" = "Meta+È";
        "Switch to Desktop 8" = "Meta+_";

        # Move window to desktop
        "Window to Desktop 1" = "Meta+1";
        "Window to Desktop 2" = "Meta+2";
        "Window to Desktop 3" = "Meta+3";
        "Window to Desktop 4" = "Meta+4";
        "Window to Desktop 5" = "Meta+5";
        "Window to Desktop 6" = "Meta+6";
        "Window to Desktop 7" = "Meta+7";
        "Window to Desktop 8" = "Meta+8";
      };
    };

    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled".value = false; # disable file indexing

      "kdeglobals"."General"."accentColorFromWallpaper".value = true;

      "kdeglobals"."KDE"."AnimationDurationFactor".value = 0;
      "kdeglobals"."KDE"."SingleClick".value = true;

      "ksplashrc"."KSplash"."Engine".value = "none";

      "kwinrc"."Compositing"."LatencyPolicy".value = "Low";
      "kwinrc"."Desktops"."Number" = {
        value = 8;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };

      "kwinrc"."TabBox"."ActivitiesMode".value = 0;
      "kwinrc"."TabBox"."LayoutName".value = "big_icons";
    };
  };
}
