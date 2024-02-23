{
  inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./armcord.nix
    ./element.nix
    ./signal.nix
  ];
}
