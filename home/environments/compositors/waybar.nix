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
        height = "40";
        # output = [ "eDP-1" "DP-3" ];

        modules-left   = [
          "hyprland/window"
          "clock"
          # "sway/language"
          # "custom/scratchpad-indicator"
          # "custom/pacman"
          # "sway/mode"
          "idle_inhibitor"
          #"custom/media"
        ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right  = [
          # "custom/cpugovernor"
          "cpu"
          "temperature"
          # "custom/gpu"
          "pulseaudio"
          "bluetooth"
          "network"
          "tray"
        ];

        # "sway/workspaces" = {
        #   disable-scroll = true;
        #   all-outputs = true;
        # };

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

    style = {

    };
  };
}
