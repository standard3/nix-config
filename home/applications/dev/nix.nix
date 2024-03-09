{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Nix language server
    rnix-lsp
  ];
}
