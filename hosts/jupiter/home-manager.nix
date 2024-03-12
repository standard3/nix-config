{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = with outputs.overlays; [
      unstable-packages
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      abel = import ../../home/users/abel.nix;
    };
    useGlobalPkgs = true;
  };
}
