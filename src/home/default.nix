{
  vars,
  shellExtra ? "",
  ...
}:

{
  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "24.05";

      shellAliases = { };

      sessionVariables = {
        "EDITOR" = vars.editor;
        "TERM" = "xterm-256color";
      };
    };

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

    programs.fzf = {
      enable = true;
      tmux = {
        enableShellIntegration = true;
      };
    };

    programs.mise = {
      enable = true;
      globalConfig = {
        tools = {
          node = "20.9.0";
          python = "latest";
          go = "latest";
          postgres = "14.10";
        };
      };
    };

    programs.starship = {
      enable = true;
      settings = {
        format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$character";
        right_format = "$time";
        time = {
          disabled = false;
          format = "$time";
        };
      };
    };

    programs.tmux = {
      enable = true;
      tmuxp.enable = true;
      prefix = "C-Space";
      baseIndex = 1;
      clock24 = true;
      mouse = true;
      historyLimit = 100000;
      sensibleOnTop = false;
      terminal = "tmux-256color";
      extraConfig = builtins.readFile ./tmux.conf;
    };

    programs.zoxide.enable = true;

    programs.zsh = {
      enable = true;
      antidote = {
        enable = true;
        plugins = [
          "rupa/z"
          "zsh-users/zsh-completions"
          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-autosuggestions"
          "jscutlery/nx-completion"
        ];
      };
      initExtra =
        ''
          # use emacs keys for navigating command prompt
          bindkey -e
        ''
        + shellExtra;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.verbose = true;
  home-manager.backupFileExtension = "backup";
}
