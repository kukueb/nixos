{ config, pkgs, ... }:

{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./qtgtktheme.nix
    ./serpantinum.nix
    ./kitty.nix
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
    nerd-fonts.fira-code
    awww
    thunar
    webcord
    easyeffects
    telegram-desktop

    kdePackages.dolphin
    kdePackages.breeze    # Recommended for proper styling/icons
    kdePackages.qtsvg     # Fixes missing/blank icons
    kdePackages.plasma-integration

    xwayland-satellite

    handbrake
    vlc

    qpwgraph
  ];

  programs.zsh = {
    enable = true;
      plugins = [
        {
          name = "zsh-vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
    ];
  };

  # programs.inir = {
  #   enable = true;
  #   service.compositor = "niri";
  #   extraPackages = [ pkgs.niri pkgs.quickshell ];
  # };

  home.stateVersion = "26.11";
  programs.home-manager.enable = true;
}
