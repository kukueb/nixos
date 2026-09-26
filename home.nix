{ inputs, config, pkgs, ... }:

{
  imports = [
    inputs.inir.homeModules.inir
  ];

  home.username = "kukueb";
  home.homeDirectory = "/home/kukueb";

  home.packages = with pkgs; [
    kitty
    firefox
    fuzzel
    waybar
    mako
    wl-clipboard
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    awww
  ];

  programs.inir = {
    enable = true;
    service.compositor = "niri";
    extraPackages = [ pkgs.niri pkgs.quickshell ];
  };

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
