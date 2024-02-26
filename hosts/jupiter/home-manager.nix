{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      abel = import ../home/users/abel.nix;
    };

    useGlobalPkgs = true;
  };
}
