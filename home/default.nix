{ username, ... }:
{
  home-manager.users.${username} = {
    imports = [
      ./alacritty.nix
      ./aliases.nix
      ./bat.nix
      ./direnv.nix
      ./eza.nix
      ./fzf.nix
      ./git.nix
      ./gpg.nix
      ./mise.nix
      ./ripgrep.nix
      ./sessionVariables.nix
      ./starship.nix
      ./ssh.nix
      ./tmux.nix
      ./zoxide.nix
      ./zsh.nix
    ];

    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.backupFileExtension = "backup";
}
