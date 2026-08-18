{ config, ... }:
{
  home.sessionVariables = {
    "EDITOR" = "nvim";
    "VISUAL" = "nvim";
    "TERM" = "xterm-256color";
    "GOPATH" = "${config.home.homeDirectory}/go";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.bun/bin"
  ];
}
