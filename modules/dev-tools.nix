{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    clang
    rustc
    rustup
    cargo
    python3

    zellij
    cmake
  ];
}
