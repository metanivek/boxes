{ username, ... }:
{
  home-manager.users.${username} = {
    imports = [
      ./aliases.nix
      ./fzf.nix
      ./sessionVariables.nix
      ./starship.nix
      ./tmux.nix
      ./zsh.nix
    ];

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.eza.enable = true;

    programs.go = {
      enable = true;
      goPath = "go";
    };

    programs.gpg.enable = true;

    programs.mise = {
      enable = true;
      globalConfig = {
        tools = {
          node = "20";
          python = "latest";
          go = "latest";
        };
      };
    };

    programs.zoxide.enable = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.backupFileExtension = "backup";
}
