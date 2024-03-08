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
        # path = ".config/hypr/default.png";
        color = "rgba(22, 22, 22, 1.0)";
        blur_size = 80;
        blur_passes = 10;
      }
    ];

    input-fields = [
      {
        size = {
          width = 300;
          height = 50;
        };

        outline_thickness = 2;

        outer_color = "rgb(151515)";
        inner_color = "rgb(200, 200, 200)";
        font_color = "rgb(10, 10, 10)";

        placeholder_text = "<i>Password...</i>";
        # hide_input = true;

        dots_size = 0.25;
        dots_spacing = 0.15;
      }
    ];

    labels = [
      {
        text = "$TIME";
        color = "rgba(200, 200, 200, 1.0)";
        font_family = "Lexend";
      }
    ];
  };
}
