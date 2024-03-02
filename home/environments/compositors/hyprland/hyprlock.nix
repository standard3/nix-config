{ inputs, pkgs, ... }:

{
  imports = [ inputs.hyprlock.homeManagerModules.default ];

  # See https://github.com/hyprwm/hyprlock/blob/main/nix/hm-module.nix
  programs.hyprlock = {
    enable = true;

    general = {
      grace = 5;
      hide_cursor = true;
    };

    backgrounds = {
      blur_size = 8;
      blur_passes = 0;
    };

    input-fields = {
      outline_thickness = 3;
      dots_size = 0.33;
      dots_spacing = 0.15;
      outer_color = "rgb(151515)";
      inner_color = "rgb(200, 200, 200)";
      font_color = "rgb(10, 10, 10)";
      placeholder_text = "<i>Input Password...</i>";
      hide_input = true;
    };

    labels = {
      text = "Welcome";
      color = "rgba(200, 200, 200, 1.0)";
      font_family = "Lexend";
    };
  };
}
