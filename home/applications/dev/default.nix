{ pkgs, ... }:

{
  imports = [
    ./python.nix
    ./nix.nix
  ];

  home.packages = with pkgs; [
    alejandra
  ];
}
