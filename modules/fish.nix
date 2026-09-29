{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
  };

  programs.starship.enable = true;


}
