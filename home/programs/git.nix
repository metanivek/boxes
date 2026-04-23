{ pkgs, ... }:
{
  home.packages = with pkgs; [
    delta
    git-absorb
  ];
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing.signByDefault = true;
    ignores = [
      ".envrc"
      "*.local"
      ".DS_Store"
      ".sisyphus"
    ];
    settings = {
      user = {
        name = "Kevin Smith";
        email = "metanivek@gmail.com";
      };
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
        line-numbers = true;
        navigate = true;
        side-by-side = true;
      };
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      merge.conflictStyle = "diff3";
      diff.colorMoved = "default";
      alias = {
        ap = "add --patch";
        br = "branch";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        ci = "commit";
        cleanup = "!git branch --merged main | grep -vE '^\\*|^[[:space:]]*main$' | xargs -n 1 git branch -d";
        cm = "commit -m";
        co = "checkout";
        d = "diff";
        dc = "diff --cached";
        find = "!git log --all --oneline -S";
        last = "log -1 HEAD";
        lo = "! f() { git log --no-color --no-decorate | bat -n -l 'Git log' ; }; f";
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        me = "!sh -c 'echo \"$(git config user.name) <$(git config user.email)>\"'";
        nuke = "reset --hard HEAD";
        pf = "push --force-with-lease";
        pr = "pull --rebase";
        root = "rev-parse --show-toplevel";
        st = "status";
        undo = "reset --soft HEAD~1";
        unstage = "reset HEAD --";
      };
    };
  };
}
