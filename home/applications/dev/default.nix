{ pkgs, ... }:

{
  imports = [
    ./python.nix
    ./nix.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    alejandra
  ];
}
