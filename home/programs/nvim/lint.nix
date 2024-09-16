{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clippy
    deadnix
    lua54Packages.luacheck
    nodePackages.jsonlint
    python311Packages.bandit
    python311Packages.mypy
    python311Packages.pycodestyle
    python311Packages.vulture
    ruff
    shellcheck
    vale
    yamllint
  ];

  programs.nixvim = {
    plugins.lint = {
      enable = true;
      lintersByFt = {
        json = [ "jsonlint" ];
        lua = [ "luacheck" ];
        markdown = [ "vale" ];
        nix = [
          "deadnix"
          "nix"
        ];
        python = [
          "bandit"
          "mypy"
          "pycodestyle"
          "ruff"
          "vulture"
        ];
        rust = [ "clippy" ];
        sh = [ "shellcheck" ];
        text = [ "vale" ];
        yaml = [ "yamllint" ];
        zsh = [ "zsh" ];
      };
    };
  };
}
