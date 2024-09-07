{ ... }:
{
  home.sessionVariables = {
    "GPG_TTY" = "$(tty)";
  };
  programs.gpg.enable = true;
}
