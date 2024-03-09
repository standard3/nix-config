{ pkgs, ... }:

{
  home.file = let
    icons = ./icons;
  in {
    ".config/wlogout/hyprpaper.conf".source = icons;
  };


  programs.wlogout = {
    enable = true;
    package = pkgs.unstable.wlogout;
    layout = [
      {
        label   = "lock";
        action  = "hyprlock";
        text    = "󰌾";
        keybind = "l";
        circular = true;
        height = 0.1;
        width = 0.1;
      }
      {
        label   = "logout";
        action  = "hyprctl dispatch exit";
        text    = "󰗽";
        keybind = "e";
        circular = true;
        height = 0.3;
        width = 0.3;
      }
      {
        label   = "shutdown";
        action  = "systemctl poweroff";
        text    = "⏻";
        keybind = "s";
        circular = true;
        height = 0.5;
        width = 0.5;
      }
      {
        label   = "suspend";
        action  = "systemctl suspend";
        text    = "󰤄";
        keybind = "u";
        circular = true;
        height = 0.7;
        width = 0.7;
      }
      {
        label   = "reboot";
        action  = "systemctl reboot";
        text    = "";
        keybind = "r";
        circular = true;
      }
    ];

    style = builtins.readFile ./style.css;
  };
}
