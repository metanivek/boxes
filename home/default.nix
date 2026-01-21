{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./aliases.nix
    ./sessionVariables.nix
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.wget
  ];
}
