{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wireshark
    unstable.gef
    unstable.cutter
    unstable.cutterPlugins.rz-ghidra
    unstable.pwntools
  ];
}
