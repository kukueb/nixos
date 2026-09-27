{ pkgs, ... }:

{
  # qt
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  home.packages = with pkgs; [
    kdePackages.breeze
    kdePackages.plasma-integration
  ];

  xdg.configFile."kdeglobals".text = ''
    [General]
    ColorScheme=BreezeDark
    widgetStyle=Breeze

    [KDE]
    widgetStyle=Breeze
  '';

  # gtk
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };

  home.sessionVariables = {
    GTK_THEME = "adw-gtk3-dark";
  };
}
