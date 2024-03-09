{ outputs, pkgs, ... }:

{
  imports = [
    outputs.homeManagerModules.swaync
  ];

  services.swaync = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
    schema = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";

    settings = {
      # General settings
      cssPriority = "user";
      image-visibility = "when-available";
      keyboard-shortcut = true;
      relative-timestamps = true;
      timeout = 6;
      timeout-low = 4;
      timeout-critical = 0;
      script-fail-notify = true;
      transition-time = 200;

      # Layer settings
      layer-shell = true;
      layer = "overlay";
      control-center-layer = "overlay";

      # Notification settings
      positionX = "right";
      positionY = "top";
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;
      notification-window-width = 400;

      notification-visibility = {
        example-name = {
          exec = "echo 'Do something'";
          urgency = "Normal";
        };
      };

      # Control center settings
      control-center-positionX = "right";
      control-center-positionY = "top";
      control-center-margin-top = 2;
      control-center-margin-bottom = 2;
      control-center-margin-left = 0;
      control-center-margin-right = 1;
      control-center-width = 380;
      control-center-height = 860;
      control-center-exclusive-zone = true;
      fit-to-screen = false;
      hide-on-action = true;
      hide-on-clear = true;

      # Widget settings
      widgets = [
        "label"
        "buttons-grid"
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];

      # Widget config
      widget-config = {
        label = {
          max-lines = 1;
          text = "";
        };

        buttons-grid = {
          actions = [
            {
              label = "󰕾";
              command = "amixer set Master toggle";
            }
            {
              label = "󰍬";
              command = "amixer set Capture toggle";
            }
            {
              label = "";
              command = "nm-connection-editor";
            }
            {
              label = "";
              command = "blueman-manager";
            }
          ];
        };

        mpris = {
          image-size = 96;
          image-radius = 6;
        };

        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " 󰎟 ";
        };

        dnd = {
          text = "Do not disturb";
        };
      };
    };

    # Custom style
    style = builtins.readFile ./style.css;
  };
}
