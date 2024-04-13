{ pkgs, ... }:

{
  imports = [
    ./cybersecurity.nix
    ./screenshot.nix
    ./obsidian.nix
    ./ssh.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    unstable.drawio
  ];
}
