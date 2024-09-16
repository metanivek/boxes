{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./aliases.nix
    ./sessionVariables.nix
    ./programs
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.wget 
  ];
}
