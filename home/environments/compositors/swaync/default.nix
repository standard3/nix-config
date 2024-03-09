{ pkgs, ... }: let


in {
  services.swaync = {
    enable = true;
  }
}
