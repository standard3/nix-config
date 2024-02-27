{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    armcord
  ];

  # todo: manually configure armcord xdg files
}
