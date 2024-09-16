{ pkgs, ... }:
{
  home.packages = with pkgs; [
    delta
    git-absorb
  ];
  programs.git = {
    enable = true;
    userName = "Kevin Smith";
    userEmail = "metanivek@gmail.com";
    lfs.enable = true;
    signing.signByDefault = true;
    ignores = [
      ".envrc"
      "*.local"
      ".DS_Store"
    ];
    extraConfig = {
      color.ui = "auto";
      branch.sort = "-committerdate";
      commit.gpgSign = true;
      core.editor = "vim";
      diff.algorithm = "histogram";
      init.defaultBranch = "main";
      pull.rebase = "true";
      push.autoSetupRemote = true;
      rerere.enabled = true;

      # delta config + related setup
      delta = {
        hyperlinks = true;
        navigate = true;
        line-numbers = true;
      };
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
    };
    aliases = {
      br = "branch";
      ci = "commit";
      co = "checkout";
      lo = "! f() { git log --no-color --no-decorate | bat -n -l 'Git log' ; }; f";
      lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
      lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      me = "!sh -c 'echo \"$(git config user.name) <$(git config user.email)>\"'";
      st = "status";
    };
  };
}
