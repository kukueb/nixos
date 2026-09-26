{ config, pkgs, lib, ... }:

let
  materiaKde = pkgs.fetchFromGitHub {
    owner = "PapirusDevelopmentTeam";
    repo = "materia-kde";
    rev = "master"; # лучше зафиксировать конкретный commit hash для воспроизводимости
    sha256 = lib.fakeSha256; # заменить на реальный хэш — nix build подскажет его при первом прогоне
  };
in
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme; # тот же Material-стиль в GTK, для консистентности
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Kvantum-варианты темы Materia из репозитория materia-kde
  xdg.configFile."Kvantum/Materia".source = "${materiaKde}/Kvantum/Materia";
  xdg.configFile."Kvantum/Materia-Dark".source = "${materiaKde}/Kvantum/Materia-Dark";
  xdg.configFile."Kvantum/Materia-Light".source = "${materiaKde}/Kvantum/Materia-Light";

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Materia-Dark
  '';

  # Настоящий Material Design для QML/Qt Quick приложений (не через Kvantum, а нативно в Qt)
  home.sessionVariables = {
    QT_QUICK_CONTROLS_STYLE = "Material";
    QT_QUICK_CONTROLS_MATERIAL_THEME = "Dark";
    QT_QUICK_CONTROLS_MATERIAL_ACCENT = "Teal";
  };

  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    qt6Packages.qtstyleplugin-kvantum
  ];
}
