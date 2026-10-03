{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      set fish_greeting
    '';
  };

  programs.starship.enable = true;


}
