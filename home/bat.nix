{ pkgs, ... }:
{
  home.packages = with pkgs.bat-extras; [
    batgrep
    batman
  ];

  programs.bat = {
    enable = true;
  };
}
