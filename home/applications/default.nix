{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./browsers
    ./dev
    ./editors
    ./social
    ./terminal
  ];
}
