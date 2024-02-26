{
  description = "std3's personnal Nix configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
    };

    # Zellij plugins
    zjstatus = {
      url = "github:dj95/zjstatus";
    };

    hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, hardware, nixpkgs, home-manager, ... } @ inputs:
  let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    nixosConfigurations = {
      jupiter = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          hardware.nixosModules.tuxedo-infinitybook-pro14-gen7
          ./hosts/jupiter
        ];
      };
    };
  };
}
