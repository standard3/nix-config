{ pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    lexend
    (nerdfonts.override { fonts = [ "MesloLGM" ]; })
  ];
}
