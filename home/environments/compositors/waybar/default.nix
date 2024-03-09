{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        # output = [ "eDP-1" "DP-3" ];

        modules-left   = [
          "custom/powermenu"
          "custom/weather"
          "hyprland/window"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right  = [
          "wireplumber"
          # "custom/gpu"
          # "custom/cpugovernor"
          "cpu"
          "temperature"
          "bluetooth"
          "network"
          "tray"
          "clock"
        ];

        # Hyprland
        "hyprland/window" = {
          format = "{}";
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹  $1";
            "Zellij (.*) - (.*)" = "  $2";
            "(.*) — Visual Studio Code" = "󰨞  $2";
          };

          separate-outputs = true;
        };

        "hyprland/workspaces" = {
          active-only = false;
          all-outputs = false;
          persistent-workspaces = {
            "*" = [ 1 2 3 4 5 6 7 8 ];
          };
          format = "{icon}";
          format-icons = {
            default = ""; # empty
            active  = ""; # filled
            urgent  = "<span color=\"#fb4934\"></span>";
          };
        };

        # Utilities
        "clock" = {
          format = "  {:%H:%M   %e %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          today-format = "<b>{}</b>";
          # on-click = "gnome-calendar";
        };

        "network" = {
          # interface = "wlan0"; // (Optional) To force the use of this interface,
          format-wifi = "  {essid}";
          format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "";
          format-alt = "{ifname}: {ipaddr}/{cidr}";

          family = "ipv4";

          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n {bandwidthUpBits}  {bandwidthDownBits}";
          tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n {bandwidthUpBits}  {bandwidthDownBits}";
        };

        "wireplumber" = {
            format = "{volume}%";
            format-muted = " {format_source}";
            format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [ "" "" "" ];
            };

            scroll-step = 3; # %, can be a float
            reverse-scrolling = true;
            on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
            on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        "bluetooth" = {
          format = "{icon}";
          format-icons = {
            connected = "";
            disconnected = "";
          };
          on-click = "blueman-manager";
        };

        "custom/weather" = {
          exec = "curl 'https://wttr.in/Angers, France?0pq&lang=fr&format=3'";
          interval = 600;
        };

        "custom/powermenu" = {
          format = "";
          on-click = "wlogout";
        };

        # System metrics
        "cpu" = {
          interval = 4;
          format = "  {max_frequency}GHz 󰇝 {usage}%";
          max-length = 13;
          min-length = 13;
          on-click = "alacritty -e btop";
          tooltip = false;
        };

        "temperature" = {
            # CPU thermal zone, see with cat /sys/class/thermal/thermal_zone*/type
            thermal-zone = 0;
            interval = 4;
            critical-threshold = 85;
            format-critical = "  {temperatureC}°C";
            format = "{icon}  {temperatureC}°C";
            format-icons = ["" "" ""];
            max-length = 7;
            min-length = 7;
        };

        # "custom/gpu": {
        #   "exec": "$HOME/.config/waybar/custom_modules/custom-gpu.sh",
        #   "return-type": "json",
        #   "format": "  {}",
        #   "interval": 2,
        #   "tooltip": "{tooltip}",
        #   "max-length": 19,
        #   "min-length": 19,
        #   "on-click": "powerupp"
        # },

        # #!/bin/bash
        # raw_clock=$(cat /sys/class/drm/card0/device/pp_dpm_sclk | egrep -o '[0-9]{0,4}Mhz \W' | sed "s/Mhz \*//")
        # clock=$(echo "scale=1;$raw_clock/1000" | bc | sed -e 's/^-\./-0./' -e 's/^\./0./')

        # raw_temp=$(cat /sys/class/drm/card0/device/hwmon/hwmon5/temp1_input)
        # temperature=$(($raw_temp/1000))
        # busypercent=$(cat /sys/class/hwmon/hwmon5/device/gpu_busy_percent)
        # deviceinfo=$(glxinfo -B | grep 'Device:' | sed 's/^.*: //')
        # driverinfo=$(glxinfo -B | grep "OpenGL version")

        # echo '{"text": "'$clock'GHz |   '$temperature'°C <span color=\"darkgray\">| '$busypercent'%</span>", "class": "custom-gpu", "tooltip": "<b>'$deviceinfo'</b>\n'$driverinfo'"}'


        # "custom/cpugovernor": {
        #   "format": "{icon}",
        #   "interval": "30",
        #   "return-type": "json",
        #   "exec": "$HOME/.config/waybar/custom_modules/cpugovernor.sh",
        #   "min-length": 2,
        #   "max-length": 2,
        #     "format-icons": {
        #         "perf": "",
        #         "sched": ""
        #     },
        # }

        # #!/bin/bash
        # if [ `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`="performance" ]; then
        #   echo '{"text": "perf", "alt": "perf", "class": "performance", "tooltip": "<b>Governor</b> Performance"}'
        #   #echo ''
        # elif [ `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`="schedutil" ]; then
        #   echo '{"text": "sched", "class": "schedutil", "tooltip": "<b>Governor</b> Schedutil"}'
        # fi

        # "custom/hello-from-waybar" = {
        #   format = "hello {}";
        #   max-length = 40;
        #   interval = "once";
        #   exec = pkgs.writeShellScript "hello-from-waybar" ''
        #     echo "from within waybar"
        #   '';
        # };
      };
    };

    style = builtins.readFile ./style.css;
  };
}
