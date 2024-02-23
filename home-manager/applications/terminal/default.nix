{
  inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./utilities.nix
    ./zellij.nix
  ];
}
