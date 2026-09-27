{ config, pkgs, lib, ... }:

let
  materiaKde = pkgs.fetchFromGitHub {
    owner = "PapirusDevelopmentTeam";
    repo = "materia-kde";
    rev = "master"; # лучше зафиксировать commit hash
    sha256 = "sha256-tZWEVq2VYIvsQyFyMp7VVU1INbO7qikpQs4mYwghAVM=";
  };
in
{
  qt = {
    enable = true;
    # platformTheme.name = "qtct"; # было "kvantum" — невалидное значение
    platformTheme.name = "qt6ct"; # было "kvantum" — невалидное значение
    style.name = "breeze";
    colorScheme.name = "noctalia";
  };

  # xdg.configFile."Kvantum/Materia".source = "${materiaKde}/Kvantum/Materia";
  # xdg.configFile."Kvantum/Materia-Dark".source = "${materiaKde}/Kvantum/Materia-Dark";
  # xdg.configFile."Kvantum/Materia-Light".source = "${materiaKde}/Kvantum/Materia-Light";
  #
  # xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
  #   [General]
  #   theme=Materia-Dark
  # '';

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qt6ct
  ];
}
