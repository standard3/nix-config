{ inputs, outputs, lib, config, pkgs, home-manager, ...}:

let
    username = "abel";
in {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    ../environments
    ../applications
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # todo: remove from here
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
