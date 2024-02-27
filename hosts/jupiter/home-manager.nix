{ inputs, outputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  nixpkgs = {
    overlays = with outputs.overlays; [
      unstable-packages
    ];

    # Nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      abel = import ../../home/users/abel.nix;
    };

    useGlobalPkgs = true;
  };
}
