{
  programs.ghostty = {
    enable = true;
    package = null; # installed via homebrew cask

    settings = {
      theme = "Tomorrow Night Bright";

      font-family = "FiraCode Nerd Font Mono";
      font-size = 14;

      copy-on-select = "clipboard";

      macos-titlebar-style = "hidden";
      maximize = true;
      window-padding-x = 0;
      window-padding-y = 0;
      macos-option-as-alt = true;

      term = "xterm-256color";
    };
  };
}
