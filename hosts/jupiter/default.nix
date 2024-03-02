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
  services.xserver = {
    enable = true;
    libinput.enable = true;
  };

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.xserver.desktopManager.plasma5.enable = true;

  environment.systemPackages = with pkgs; [
    # Common packages
    btop
    bat
    ripgrep
    fd
    eza
    wget
    curl
    file
    killall

    # Utilities
    pciutils
    libva-utils
    nvidia-vaapi-driver
    udiskie
    xdg-utils
    brightnessctl
    playerctl
    pavucontrol
    networkmanagerapplet

    # Wayland
    unstable.way-displays
    unstable.hyprpaper
    wlr-randr
    wl-clipboard
    hyprpicker

    # Security
    polkit-kde-agent
  ];

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  systemd = {
    user.services.polkit-kde-authentication-agent-1 = {
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Users
  users.users = {
    abel = {
      initialPassword = "azerty123";
      isNormalUser = true;
      shell = pkgs.fish;

      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];

      extraGroups = [ "wheel" "networkmanager" "input" ];
    };
  };

  programs.fish.enable = true;

  # Enable hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    xwayland.enable = true;
  };

  # Hint electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
