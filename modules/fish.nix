{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      set greeting_fish
    '';
  };

  programs.starship.enable = true;


}
