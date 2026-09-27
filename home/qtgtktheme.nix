{ config, pkgs, lib, ... }:

{
  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "breeze";
  };

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    style=Breeze
    color_scheme_path=/home/kukueb/.config/qt6ct/colors/noctalia.conf
  '';
}
