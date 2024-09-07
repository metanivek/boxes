{ config, ... }:
{
  home.sessionVariables = {
    "EDITOR" = "vim";
    "VISUAL" = "vim";
    "TERM" = "xterm-256color";
    "GOPATH" = "${config.home.homeDirectory}/go";
  };
}
