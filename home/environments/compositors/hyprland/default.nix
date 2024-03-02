{ inputs, pkgs, ... }:

{
  imports = [ ./way-displays.nix ];

  # look for :
  # - https://github.com/hyprwm/hypridle
  # - https://github.com/hyprwm/hyprlock
  # - https://github.com/hyprwm/hyprpaper
  # - https://sr.ht/~emersion/kanshi/
  # - https://github.com/alex-courtis/way-displays

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    enableNvidiaPatches = true;

    settings = {
      # Variables
      "$mod" = "SUPER";

      # Monitor configuration
      monitor = [
        ", highrr,      auto, 1"
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
        # "dbus-update-activation-environment --all &"
        # "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # "/usr/bin/gnome-keyring-daemon --start --components=secrets &"
        # "/usr/lib/polkit-kde-authentication-agent-1 &"
        # "swayidle -w timeout 300 'gtklock' before-sleep 'gtklock' &"
        # "swayidle -w timeout 450 'systemctl suspend' &"

        # Clipboard history
        # "wl-paste --watch cliphist store &"

        # Cursor
        # "hyprctl setcursor Bibata-Modern-Classic 24"
      ];

      # General configuration
      input = {
        # Mouse
        force_no_accel = false;

        # Keyboard
        kb_layout = "fr";
        follow_mouse = 1;
        numlock_by_default = true;

        touchpad = {
        disable_while_typing = true;
            clickfinger_behavior = true;
            scroll_factor = 0.5;
        };
        scroll_method = "2fg";
      };

      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = true;
        workspace_swipe_distance = "1200px";
        workspace_swipe_fingers = 3;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_min_speed_to_force = 5;

        workspace_swipe_create_new = true;
      };

      general = {
        max_fps = 165;

        # Gaps and border
        gaps_in = 4;
        gaps_out = 4;
        border_size = 1;

        # Fallback colors
        # col = {
        #   active_border = "rgba(0DB7D4FF) rgba(7AA2F7FF) rgba(9778D0FF) 45deg";
        #   inactive_border = "rgba(04404aaa)";
        # };

        # Functionality
        # resize_on_border = true;
        no_focus_fallback = true;
        layout = "dwindle";

        #focus_to_other_workspaces = true;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      dwindle = {
        preserve_split = true;
        #no_gaps_when_only = true;
        smart_resizing = false;
      };

      decoration = {
        rounding = 10;

        # Shadow
        drop_shadow = false;
        shadow_range = 30;
        shadow_render_power = 10;
        "col.shadow" = "rgba(2D3031FF)";

        # Dim
        dim_inactive = true;
        dim_strength = 0.1;
        dim_special = 0;
      };

      animations = {
        enabled = true;

        # Animation curves
        bezier = [
          "md3_standard,  0.2,  0,   0,    1"
          "md3_decel,     0.05, 0.7, 0.1,  1"
          "md3_accel,     0.3,  0,   0.8,  0.15"
          "overshot,      0.05, 0.9, 0.1,  1.1"
          "crazyshot,     0.1,  1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1,  1.0"
          "fluent_decel,  0.1,  1,   0,    1"
        ];

        # Animation configs
        animation = [
          "windows,          1, 2,  md3_decel, popin 80%"
          "border,           1, 10, default"
          "fade,             1, 2,  default"
          "workspaces,       1, 3,  md3_decel"
          "specialWorkspace, 1, 3,  md3_decel, slidevert"
        ];
      };

      misc = {
        vfr = 1;
        vrr = 1;
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        #suppress_portal_warnings = true;
        enable_swallow = true;

        disable_autoreload = false;
        disable_hyprland_logo = true;
      };

      # Key bindings
      bind = [
        # Applications
        "SUPER, RETURN, exec, ${pkgs.alacritty}/bin/alacritty"
        "SUPER, E,      exec, ${pkgs.dolphin}/bin/dolphin"
        "SUPER, W,      exec, ${pkgs.firefox}/bin/firefox"
        "SUPER, SPACE,  exec, ${inputs.anyrun.packages.${pkgs.system}.default}/bin/anyrun"

        # Utilities
        # ",            PRINT,  exec, QT_QPA_PLATFORM=xcb flameshot gui"
        # "SUPER SHIFT, C,      exec, hyprpicker -a"
        # "SUPER,       C,      exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"

        # Lock screen
        # "SUPER,       L,      exec, swaylock -f --config ~/.config/swaylock/config"
        # "SUPER SHIFT, L,      exec, swaylock -f --config ~/.config/swaylock/config && systemctl suspend"

        # Actions
        "SUPER,       Q,     killactive,"
        "SUPER ALT,   Space, togglefloating,"
        "SUPER,       J,     togglesplit,"
        "SUPER,       F,     fullscreen, 0"
        "SUPER Shift, F,     fullscreen, 1"

        # Swap windows
        "SUPER SHIFT, left,  movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up,    movewindow, u"
        "SUPER SHIFT, down,  movewindow, d"

        # Move focus
        "SUPER, left,         movefocus, l"
        "SUPER, right,        movefocus, r"
        "SUPER, up,           movefocus, u"
        "SUPER, down,         movefocus, d"
        "SUPER, BracketLeft,  movefocus, l"
        "SUPER, BracketRight, movefocus, r"

        # Workspace, window, tab switch with keyboard
        "SUPER CTRL,       right,        workspace, +1"
        "SUPER CTRL,       left,         workspace, -1"
        "SUPER CTRL,       BracketLeft,  workspace, -1"
        "SUPER CTRL,       BracketRight, workspace, +1"
        "SUPER CTRL,       up,           workspace, -5"
        "SUPER CTRL,       down,         workspace, +5"
        "SUPER,            Page_Down,    workspace, +1"
        "SUPER,            Page_Up,      workspace, -1"
        "SUPER CTRL,       Page_Down,    workspace, +1"
        "SUPER CTRL,       Page_Up,      workspace, -1"
        "SUPER ALT,        Page_Down,    movetoworkspace, +1"
        "SUPER ALT,        Page_Up,      movetoworkspace, -1"
        "SUPER SHIFT,      Page_Down,    movetoworkspace, +1"
        "SUPER SHIFT,      Page_Up,      movetoworkspace, -1"
        "SUPER CTRL SHIFT, Right,        movetoworkspace, +1"
        "SUPER CTRL SHIFT, Left,         movetoworkspace, -1"
        "SUPER SHIFT,      mouse_down,   movetoworkspace, -1"
        "SUPER SHIFT,      mouse_up,     movetoworkspace, +1"
        "SUPER ALT,        mouse_down,   movetoworkspace, -1"
        "SUPER ALT,        mouse_up,     movetoworkspace, +1"

        # Window split ratio
        "SUPER, Minus,      splitratio, -0.1"
        "SUPER, Equal,      splitratio,  0.1"
        "SUPER, Semicolon,  splitratio, -0.1"
        "SUPER, Apostrophe, splitratio,  0.1"

        # Switch workspaces with mainMod + [1-8]
        "SUPER, ampersand,  workspace, 1"
        "SUPER, eacute,     workspace, 2"
        "SUPER, quotedbl,   workspace, 3"
        "SUPER, apostrophe, workspace, 4"
        "SUPER, parenleft,  workspace, 5"
        "SUPER, minus,      workspace, 6"
        "SUPER, egrave,     workspace, 7"
        "SUPER, underscore, workspace, 8"

        # Special workspace
        "SUPER,      S,   togglespecialworkspace,"
        "SUPER CTRL, S,   togglespecialworkspace,"
        "ALT,        Tab, cyclenext"
        "ALT,        Tab, bringactivetotop,"   # bring it to the top

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "SUPER SHIFT, ampersand,  movetoworkspace, 1"
        "SUPER SHIFT, eacute,     movetoworkspace, 2"
        "SUPER SHIFT, quotedbl,   movetoworkspace, 3"
        "SUPER SHIFT, apostrophe, movetoworkspace, 4"
        "SUPER SHIFT, parenleft,  movetoworkspace, 5"
        "SUPER SHIFT, minus,      movetoworkspace, 6"
        "SUPER SHIFT, egrave,     movetoworkspace, 7"
        "SUPER SHIFT, underscore, movetoworkspace, 8"
        "SUPER SHIFT CTRL, Up,    movetoworkspacesilent, special"
        "SUPER ALT,        S,     movetoworkspacesilent, special"

        # Scroll through existing workspaces with (Control) + SUPER + scroll
        "SUPER, mouse_up,          workspace, +1"
        "SUPER, mouse_down,        workspace, -1"
        "ControlSUPER, mouse_up,   workspace, +1"
        "ControlSUPER, mouse_down, workspace, -1"
      ];

      bindm = [
        # Move/resize windows with SUPER + LMB/RMB and dragging
        "SUPER,      mouse:272, movewindow"
        "SUPER,      mouse:273, resizewindow"
        "SUPER,      mouse:274, movewindow"
        "SUPER,      Z,         movewindow"
      ];

      binde = [
        # Volume
        ", XF86AudioMicMute, exec, volumectl -m toggle-mute"

        # Media
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl stop"
      ];

      bindl = [
        # Volume
        ", XF86AudioMute, exec, volumectl toggle-mute"
      ];

      bindle = [
        # Volume
        ", XF86AudioRaiseVolume, exec, volumectl -u up"
        ", XF86AudioLowerVolume, exec, volumectl -u down"

        # Brightness
        ", XF86MonBrightnessUp,   exec, light -A 3"
        ", XF86MonBrightnessDown, exec, light -U 3"
      ];

      # Window rules
      windowrule = [
        # Applications
        "float, ^(steam)$"
        "float, ^(guifetch)$"

        # Dialogs
        "float, title:^(Open File)(.*)$"
        "float, title:^(Select a File)(.*)$"
        "float, title:^(Choose wallpaper)(.*)$"
        "float, title:^(Open Folder)(.*)$"
        "float, title:^(Save As)(.*)$"
        "float, title:^(Library)(.*)$ "
      ];
    };
  };
}
