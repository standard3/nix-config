{
  inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./nvim.nix
    ./vscode.nix
  ];
}
