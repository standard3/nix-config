{
  inputs
, lib
, config
, pkgs
, ...
}: let
    username = "abel";
in {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    ../environments
    ../applications
  ];

  nixpkgs = {
    # Nixpkgs instance
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
    };
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  programs.neovim.enable = true;

  home.packages = with pkgs; [
    firefox

    # related to editor
    rnix-lsp
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    userName  = "std3";
    userEmail = "67806187+standard3@users.noreply.github.com";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
