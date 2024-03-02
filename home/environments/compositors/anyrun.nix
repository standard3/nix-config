{ inputs, pkgs, ... }:

{
  imports = [ inputs.anyrun.homeManagerModules.default ];

  programs.anyrun = {
    enable = true;
  };
}
