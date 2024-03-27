{ pkgs, ... }:

{
  imports = [
    ./cybersecurity.nix
    ./obsidian.nix
    ./ssh.nix
  ];

  home.packages = with pkgs; [
    unstable.drawio
  ];
}
