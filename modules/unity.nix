{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = [ pkgs.unityhub ];
  hardware.graphics.enable = true;
}
