{
  programs.zsh = {
    enable = true;

    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-completions"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
      ];
    };

    initContent = ''
      # use emacs keys for navigating command prompt
      bindkey -e
    '';
  };
}
