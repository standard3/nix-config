{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      abel = import ../home-manager/users/abel.nix;
    };

    useGlobalPkgs = true;
  };
}
