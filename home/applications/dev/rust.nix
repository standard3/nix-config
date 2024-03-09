{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # maybe see https://discourse.nixos.org/t/helix-rust-analyzer-failed-to-spawn-one-or-more-proc-macro-servers/35982/2
    # Rust environment
    cargo
    rustc
    rust-analyzer
    rustfmt
    clippy
  ];
}
