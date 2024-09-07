{ ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$character";
      # right_format = "$time";
      # time = {
      #   disabled = false;
      #   format = "$time";
      # };
    };
  };
}
