{ pkgs, ... }:

{
  services.flameshot.package = {
    enable = true;
    settings = {
      # see https://github.com/flameshot-org/flameshot/blob/master/flameshot.example.ini
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;
      };
    };
  };
}
