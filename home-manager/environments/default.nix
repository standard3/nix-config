{
  inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ./compositors/hyprland
    ./desktop/kde
  ];
}
