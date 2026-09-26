{ config, pkgs, ... }:

{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./qtgtktheme.nix
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

    xwayland-satellite

    handbrake
    vlc
  ];

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      shell = "zsh";
    };
  };

  # programs.noctalia = {
  #   enable = true;
  #   # settings = {};
  # };

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
