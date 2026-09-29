{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      # shell = "zsh";
      background = "#101010";
      background_opacity = "0.7";
      confirm_os_window_close = -1;
      window_padding_width = 8;
    };
  };
}
