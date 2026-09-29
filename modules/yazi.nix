{ ... }:
{
  programs.yazi = {
    enable = true;
    settings = {
      manager.yazi.show_hidden = true;
    };
  };
}
