{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [
    pkgs.unityhub
    (pkgs.callPackage ./rider-fhs.nix { })
  ];
  hardware.graphics.enable = true;
}
