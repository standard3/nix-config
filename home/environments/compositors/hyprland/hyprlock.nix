{ inputs, pkgs, ... }:

{
  imports = [ inputs.hyprlock.homeManagerModules.default ];

  # See https://github.com/hyprwm/hyprlock/blob/main/nix/hm-module.nix
  programs.hyprlock = {
    enable = true;

    general = {
      grace = 5;
      hide_cursor = false;
    };

    backgrounds = [
      {
        monitor = "";
        path = ".config/hypr/default.png";   # only png supported for now
        color = "rgba(22, 22, 22, 1.0)";

        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_size = 4;
        blur_passes = 3; # 0 disables blurring
        noise = 0.0117;
        contrast = 1.3000; # Vibrant!!!
        brightness = 0.8000;
        vibrancy = 0.2100;
        vibrancy_darkness = 0.0;
      }
    ];

    input-fields = [
      {
        monitor = "";

        size = {
          width = 250;
          height = 50;
        };

        position = {
          x = 0;
          y = -150;
        };
        fade_on_empty = true;

        outline_thickness = 3;

        outer_color = "rgb(98971a)";
        inner_color = "rgb(282828)";
        font_color = "rgb(98971a)";

        placeholder_text = "<i>Password...</i>";
        hide_input = false;

        dots_size = 0.2;
        dots_spacing = 0.64;
        dots_center = true;

        halign = "center";
        valign = "center";
      }
    ];

    labels = [
      {
        monitor = "";
        text = "cmd[update:1000] echo \"<b><big> $(date +\"%H:%M:%S\") </big></b>\"";
        color = "rgb(ebdbb2)";
        font_size = 64;
        font_family = "Lexend";
        position = {
          x = 0;
          y = 16;
        };
        halign = "center";
        valign = "center";
      }
      {
        monitor = "";
        text = "Type to unlock...";
        color = "rgb(ebdbb2)";
        font_size = 16;
        font_family = "Lexend";
        position = {
          x = 0;
          y = 30;
        };
        halign = "center";
        valign = "bottom";
      }
    ];
  };
}
