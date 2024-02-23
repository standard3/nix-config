{
  inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./browsers
    ./editors
    ./social
    ./terminal
  ];
}
