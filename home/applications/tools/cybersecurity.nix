{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wireshark
    unstable.gef
    cutter
    cutterPlugins.rz-ghidra
    pwntools
  ];
}
