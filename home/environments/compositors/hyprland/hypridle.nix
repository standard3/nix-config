{ inputs, pkgs, ... }:

{
  imports = [ inputs.hypridle.homeManagerModules.default ];

  # See https://github.com/hyprwm/hypridle/blob/main/nix/hm-module.nix
  services.hypridle = {
    enable = true;
    beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
    lockCmd = lib.getExe inputs.hyprlock.packages.${pkgs.system}.default;

    listeners = [
      {
        timeout = 330;
        onTimeout = pkgs.writeShellScript "suspend-script" ''
          ${pkgs.pipewire}/bin/pw-cli i all 2>&1 | ${pkgs.ripgrep}/bin/rg running -q
          # only suspend if audio isn't running
          if [ $? == 1 ]; then
            ${pkgs.systemd}/bin/systemctl suspend
          fi
        ''.outPath;
      }
    ];
  };
}
