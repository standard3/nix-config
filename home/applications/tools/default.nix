{ pkgs, ... }:

{
  imports = [
    ./cybersecurity.nix
    ./flameshot.nix
    ./obsidian.nix
    ./ssh.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    unstable.drawio
  ];
}
