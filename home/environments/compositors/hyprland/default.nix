{ inputs, config, pkgs, ... }:
let
  change-display = pkgs.writeScript "change-display.sh" ''
    #! /run/current-system/sw/bin/sh

    systemctl --user restart kanshi
    chosen=$(printf "󰍺  Extend\n󰍹  External\n󰪫  Internal" | anyrun)

    case "$chosen" in
      "󰍺  Extend") kanshictl switch extend ;;
      "󰍹  External") kanshictl switch external ;;
      "󰪫  Internal") kanshictl switch undocked ;;
      *) exit 1 ;;
    esac
  '';
in
{
  imports = [
    ./hyprpaper.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    kanshi
  ];

  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    profiles =
      let
        integratedMonitor = "eDP-1";
        externalMonitor = "DP-3";
      in
      {
        # Dock
        undocked = {
          outputs = [
            {
              status = "enable";
              criteria = integratedMonitor;
            }
          ];
        };

        docked = {
          outputs = [
            {
              status = "disable";
              criteria = integratedMonitor;
            }
            {
              status = "enable";
              criteria = externalMonitor;
            }
          ];

          exec =
            let
              moveworkspacetomonitor = workspace: monitor:
                "${pkgs.hyprland}/bin/hyprctl dispatch moveworkspacetomonitor ${workspace} ${monitor}";
            in
            map (n: moveworkspacetomonitor n externalMonitor) [ "2" "3" "4" "5" "6" "7" "8" ];
        };

        # Lid
        lid_closed = {
          outputs = [
            {
              status = "enable";
              criteria = externalMonitor;
            }
          ];
        };

        # Random external monitor
        extend = {
          outputs = [
            {
              criteria = integratedMonitor;
              status = "enable";
            }
            {
              criteria = "*";
              status = "enable";
            }
          ];
        };

        external = {
          outputs = [
            {
              criteria = integratedMonitor;
              status = "disable";
            }
            {
              criteria = "*";
              status = "enable";
            }
          ];
        };
      };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    enableNvidiaPatches = true;

    settings =
      let
        integratedMonitor = "eDP-1, 2880x1800@90, auto, 1.2";
        externalMonitor = "DP-3, 2560x1440@165, -2560x0, 1";

        hyprland = config.wayland.windowManager.hyprland.package;

        lid-switch = pkgs.writeScript "lid-switch.sh" ''
          if [[ "$(${hyprland}/bin/hyprctl monitors) | grep '\sDP-[0-9]+'" ]]; then
            if [[ $1 == "open" ]]; then
              ${hyprland}/bin/hyprctl keyword monitor "${integratedMonitor}"
            else
              ${hyprland}/bin/hyprctl keyword monitor "eDP-1,disable"
            fi
          fi

          systemctl restart --user kanshi.service
        '';
      in
      {
        # Variables
        "$mod" = "SUPER";

        env = [
          # Nvidia fixes
          "LIBVA_DRIVER_NAME, nvidia"
          "GBM_BACKEND, nvidia-drm"
          "GDK_BACKEND, wayland, x11"
          "__GLX_VENDOR_LIBRARY_NAME, nvidia"
          "__GL_GSYNC_ALLOWED, 1"
          "__GL_VRR_ALLOWED, 1"
          #"WLR_DRM_DEVICES, /dev/dri/card0" # Iris Xe Graphics
          "WLR_DRM_DEVICES, /dev/dri/card1" # GeForce RTX 3050 6GB Laptop GPU
          "WLR_RENDERER_ALLOW_SOFTWARE, 1"
          "WLR_DRM_NO_ATOMIC, 1"
          "WLR_USE_LIBINPUT, 1"
        ];

        # Monitor configuration
        monitor = [
          integratedMonitor
          externalMonitor
          ", preferred, auto, 1"
        ];

        # Core components (authentication, idle daemon, etc.)
        exec-once = [
          # Screenshots
          # "c-once=QT_QPA_PLATFORM=xcb flameshot &"

          "${pkgs.networkmanagerapplet}/bin/nm-applet &"

          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];

        exec = [
          "systemctl --user restart kanshi"
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
          border_size = 3;

          "col.active_border" = "rgb(98971a)";
          "col.inactive_border" = "rgb(282828)";

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
          vfr = true;
          vrr = 1;
          focus_on_activate = true;
          animate_manual_resizes = false;
          animate_mouse_windowdragging = false;
          #suppress_portal_warnings = true;
          enable_swallow = true;

          mouse_move_enables_dpms = true;
          key_press_enables_dpms = true;

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
          "SUPER, P,      exec, ${change-display}"
          ",      PRINT,  exec, ${pkgs.grim}/bin/grim -g (${pkgs.slurp}/bin/slurp) - | ${pkgs.swappy}/bin/swappy -f -"
          # "SUPER SHIFT, C,      exec, hyprpicker -a"
          # "SUPER,       C,      exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --dmenu | cliphist decode | wl-copy"

          # Lock screen
          "SUPER,       L,      exec, ${inputs.hyprlock.packages.${pkgs.system}.default}/bin/hyprlock"

          # Actions
          "SUPER,       Q,     killactive,"
          "SUPER ALT,   Space, togglefloating,"
          "SUPER,       J,     togglesplit,"
          "SUPER,       F,     fullscreen, 0"
          "SUPER Shift, F,     fullscreen, 1"
          "SUPER,       Y,     pin"

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
          "ALT,        Tab, bringactivetotop," # bring it to the top

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
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # Media
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioStop, exec, playerctl stop"
        ];

        bindl = [
          # Volume
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          # Laptop lid switch
          # lid opened
          # ", switch:off:Lid Switch, exec, hyprctl keyword monitor ${lid-switch} open"
          # lid closed
          # ", switch:on:Lid Switch,  exec, hyprctl keyword monitor ${lid-switch} close"
        ];

        bindle = [
          # Volume
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"

          # Brightness
          ", XF86MonBrightnessUp,   exec, brightnessctl set 5%+"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

          # Resize window
          "SUPER ALT, left,    resizeactive, -20 0"
          "SUPER ALT, right,   resizeactive, 20 0"
          "SUPER ALT, up,      resizeactive, 0 -20"
          "SUPER ALT, down,    resizeactive, 0 20"
        ];

        # Window rules
        windowrule = [
          # Applications
          "float, ^(steam)$"
          "float, ^(guifetch)$"

          # Firefox Picture-in-Picture
          "float, title:^(Picture-in-Picture)$"
          "pin,   title:^(Picture-in-Picture)$"

          # Dialogs
          "float, title:^(Open File)(.*)$"
          "float, title:^(Select a File)(.*)$"
          "float, title:^(Choose wallpaper)(.*)$"
          "float, title:^(Open Folder)(.*)$"
          "float, title:^(Save As)(.*)$"
          "float, title:^(Library)(.*)$ "
        ];

        # Layer rules
        layerrule = [
          "blur, gtk-layer-shell"
        ];
      };
  };
}
