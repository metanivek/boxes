{ pkgs, ... }:
{
  home.packages = with pkgs; [
    elan
    resvg
  ];
}
