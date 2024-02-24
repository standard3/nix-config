{ config, ... }:

{
  # Nvidia drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;

    # Nvidia power management
    # todo

    open = false;
    nvidiaSettings = true;

    prime = {
      intelBusId  = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";

      offload = {
        enable = true;
	      enableOffloadCmd = true;
      };
    };

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
