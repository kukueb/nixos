{ pkgs, ... }:

{
  users.users.kukueb.extraGroups = [ "dialout" ];

  services.udev.packages = [ pkgs.platformio-core.udev ];

  programs.nix-ld.enable = true;
}
