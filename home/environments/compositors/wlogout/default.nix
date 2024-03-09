{ pkgs, ... }:

{
  programs.wlogout = {
    enable = true;
    package = pkgs.unstable.wlogout;
    layout = [
      {
        label   = "lock";
        action  = "hyprlock";
        text    = "lock";
        keybind = "l";
        circular = true;
        height = 0.5;
        width = 0.5;
      }
      {
        label   = "logout";
        action  = "hyprctl dispatch exit";
        text    = "logout";
        keybind = "e";
      }
      {
        label   = "shutdown";
        action  = "systemctl poweroff";
        text    = "power_settings_new";
        keybind = "s";
      }
      {
        label   = "suspend";
        action  = "systemctl suspend";
        text    = "bedtime";
        keybind = "u";
      }
      {
        label   = "reboot";
        action  = "systemctl reboot";
        text    = "restart_alt";
        keybind = "r";
      }
    ];

    style = builtins.readFile ./style.css;
  };
}
