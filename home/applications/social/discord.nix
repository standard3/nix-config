{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vesktop
  ];

  # todo: Manually edit armcord config file in .config/Armcord/
  # - add vencord
  # - add custom css
  # - add custom plugins
}
