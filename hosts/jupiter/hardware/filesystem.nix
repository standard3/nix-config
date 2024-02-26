{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0d9e7618-e415-4386-b04d-1a9d00dbfc14";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5E6E-CD46";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/e04c716d-5ca6-4f48-934b-fdd192b51bf6"; } ];
}
