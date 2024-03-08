{ inputs, lib, pkgs, ... }:

{
  imports = [ inputs.hypridle.homeManagerModules.default ];

  # See https://github.com/hyprwm/hypridle/blob/main/nix/hm-module.nix
  services.hypridle = let
    hyprlock = lib.getExe inputs.hyprlock.packages.${pkgs.system}.default;
    hyprlandPkg = inputs.hyprland.packages.${pkgs.system}.default;

    suspendScript = pkgs.writeShellScript "suspend-script" ''
      ${pkgs.pipewire}/bin/pw-cli i all 2>&1 | ${pkgs.ripgrep}/bin/rg running -q
      # only suspend if audio isn't running
      if [ $? == 1 ]; then
        ${pkgs.systemd}/bin/systemctl suspend
      fi
    '';
  in {
    enable = true;
    lockCmd = hyprlock;
    beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";

    listeners = [
      {
        timeout = 300;
        onTimeout = hyprlock;
      }
      {
        timeout = 600;
        # onTimeout =
        #   "${hyprlandPkg}/bin/hyprctl dispatch dpms off";
        # onResume =
        #   "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 900;
        onTimeout = suspendScript.outPath;
      }
    ];
  };
}
