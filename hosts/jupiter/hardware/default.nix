{ lib, config, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./boot.nix
    ./filesystem.nix
    ./nvidia.nix
    ./pm.nix
  ];

  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.hardware.bolt.enable = true;

  powerManagement.enable = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
