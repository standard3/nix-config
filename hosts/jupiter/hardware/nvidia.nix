{ lib, config, pkgs, ... }:

{
  # See https://nixos.wiki/wiki/Nvidia

  # Load nvidia drivers at boot
  boot = {
    initrd.kernelModules = [ "nvidia" ];
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

    extraModprobeConfig = ''
      options i915 force_probe=46a6
    '';
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      open = false;
      nvidiaSettings = true;

      # Modesetting is required
      modesetting.enable = true;

      # Nvidia power management
      powerManagement.enable = false;

      prime = {
        intelBusId  = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";

        sync.enable = true;
        # offload = {
        #   enable = true;
        #   enableOffloadCmd = true;
        # };
      };

      dynamicBoost.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    glxinfo
  ];

  # specialisation = {
  #   on-the-go.configuration = {
  #     system.nixos.tags = [ "on-the-go" ];
  #     hardware.nvidia = {
  #       prime.offload.enable = lib.mkForce true;
  #       prime.offload.enableOffloadCmd = lib.mkForce true;
  #       prime.sync.enable = lib.mkForce false;
  #     };
  #   };
  # };
}
