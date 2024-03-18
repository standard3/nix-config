{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wireshark
    unstable.gef
    unstable.cutter
    unstable.pwntools
  ];
}
