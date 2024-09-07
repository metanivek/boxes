{ username, ... }:
{
  home-manager.users.${username} = {
    imports = [
      ./aliases.nix
      ./sessionVariables.nix
      ./programs
    ];

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.backupFileExtension = "backup";
}
