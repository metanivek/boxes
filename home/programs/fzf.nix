{ ... }:
{
  programs.fzf = {
    enable = true;
    tmux = {
      enableShellIntegration = true;
    };
  };

  programs.zsh = {
    antidote.plugins = [ "Aloxaf/fzf-tab" ];
    initExtra = ''
      #
      # fzf-tab configuration
      #

      # disable sort when completing `git checkout`
      zstyle ':completion:*:git-checkout:*' sort false
      # set descriptions format to enable group support
      # NOTE: don't use escape sequences here, fzf-tab will ignore them
      zstyle ':completion:*:descriptions' format '[%d]'
      # set list-colors to enable filename colorizing
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
      zstyle ':completion:*' menu no
      # preview directory's content with eza when completing cd
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      # switch group using `<` and `>`
      zstyle ':fzf-tab:*' switch-group '<' '>'
      # use tmux popup for fzf-tab
      zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
      zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
      zstyle ':fzf-tab:*' popup-min-size 50 8
    '';
  };
}
