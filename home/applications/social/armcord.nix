{ pkgs, ... }:
{
  home.packages = with pkgs; [
    armcord
  ];

  # todo: Manually edit armcord config file in .config/Armcord/
  # - add vencord
  # - add custom css
  # - add custom plugins
}
