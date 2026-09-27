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
    color_scheme_path=/nix/store/nahdjdqrzf5gcppbzf6cgbdpibf8nm95-qt6ct-0.11/share/qt6ct/colors/darker.conf
    '';
}
