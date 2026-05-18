{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clippy
    deadnix
    lua54Packages.luacheck
    python312Packages.bandit
    python312Packages.mypy
    python312Packages.pycodestyle
    python312Packages.vulture
    ruff
    shellcheck
    vale
    yamllint
  ];

  programs.nixvim = {
    plugins.lint = {
      enable = true;
      lintersByFt = {
        json = [ ];
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
