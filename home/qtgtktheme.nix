{
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
}
