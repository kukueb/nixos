{ inputs, ... }:
{
  
  imports = [
    inputs.homeManager.kitty.default
  ];

  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      shell = "zsh";
      background = "#101010";
      background_opacity = "0.7";
    };
  };
}
