{ inputs, lib, pkgs, config, ... }:

{
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./hardware
    ../common

    ./home-manager.nix
  ];

  networking.hostName = "jupiter";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    btop
    bat
    ripgrep
    eza
    wget
    curl

    armcord
  ];

  # Users
  users.users = {
    abel = {
      initialPassword = "azerty123";
      isNormalUser = true;
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];

      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  programs.fish.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
