{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Python
    (python3.withPackages (ps:
      with ps; [
        pip
        virtualenv
      ]))
    pipenv
  ];
}
