{
  wayland.windowManager.hyprland = {
    enable = true;

    # Environment variables to be imported in the systemd & D-Bus user environment.
    variables = [ ];

    settings = {
      # Variables
      "$mod" = "SUPER";

      # Monitor configuration
      monitor = [
        ", highrr,      auto, 1"
        ", addreserved, 40,   0, 0, 0"
      ];

      # Core components (authentication, idle daemon, etc.)
      exec-once = [
        # Wallpaper
        # "swww init && swww img ~/.config/eww/images/wallpaper --transition-step 230 --transition-fps 60 --transition-type grow --transition-angle 30 --transition-duration 1"

        # Status bar
        # "eww daemon && eww open bar && eww open b"

        # Screenshots
        # "c-once=QT_QPA_PLATFORM=xcb flameshot &"

        # Core components (authentication, lock screen, notification daemon)
        "dbus-update-activation-environment --all &"
        "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "/usr/bin/gnome-keyring-daemon --start --components=secrets &"
        "/usr/lib/polkit-kde-authentication-agent-1 &"
        "swayidle -w timeout 300 'gtklock' before-sleep 'gtklock' &"
        "swayidle -w timeout 450 'systemctl suspend' &"

        # Clipboard history
        "wl-paste --watch cliphist store &"

        # Cursor
        "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      # General configuration


      # Key bindings


      # Window rules
    };
  };
}
