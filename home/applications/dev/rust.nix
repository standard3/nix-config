{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Rust environment
    cargo
    rustc
    rust-analyzer
    rust-src
    rustlings
    rustfmt
    clippy
  ];
}
