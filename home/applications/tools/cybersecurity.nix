{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wireshark
    unstable.gef
  ];
}
