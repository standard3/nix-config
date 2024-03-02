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
          "clock"
          "idle_inhibitor"
          "custom/weather"
          "hyprland/window"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right  = [
          # "custom/cpugovernor"
          "cpu"
          "temperature"
          # "custom/gpu"
          "wireplumber"
          "bluetooth"
          "network"
          "tray"
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

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            "activated" = " ";
            "deactivated" = " ";
          };
          tooltip = true;
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
            format = "{icon} {volume}% {format_source}";
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
            # on-click = "pavucontrol";
            # on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        };

        "custom/weather" = {
          exec = "curl 'https://wttr.in/?format=1'";
          interval = 3600;
        };

        # System metrics
        "cpu" = {
          interval = 1;
          format = "  {max_frequency}GHz <span color=\"darkgray\">| {usage}%</span>";
          max-length = 13;
          min-length = 13;
          # on-click = "kitty -e htop --sort-key PERCENT_CPU";
          tooltip = false;
        };

        "temperature" = {
            #thermal-zone = 1;
            interval = 4;
            hwmon-path = "/sys/class/hwmon/hwmon3/temp1_input";
            critical-threshold = 74;
            format-critical = "  {temperatureC}°C";
            format = "{icon}  {temperatureC}°C";
            format-icons = ["" "" ""];
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
