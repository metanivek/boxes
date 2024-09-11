{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    tmuxp.enable = true;
    prefix = "C-Space";
    aggressiveResize = true;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    historyLimit = 100000;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour "macchiato" # latte,frappe, macchiato or mocha
          set -g @catppuccin_status_background "default"
          set -g @catppuccin_status_modules_left "null"
          set -g @catppuccin_status_justify "left"

          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_middle_separator ". "

          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_current_fill "all"

          set -g @catppuccin_status_modules_right "date_time"
          set -g @catppuccin_date_time_text "%H:%M"
          set -g @catppuccin_status_left_separator  "█"
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
        '';
      }
      extrakto
    ];
    extraConfig = ''
      # --------------------------------- #
      # extra config                      #
      # --------------------------------- #

      # colors / cursor
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # status bar
      set-option -g status-position bottom

      # reload
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded tmux.conf"

      # toggle status
      unbind t
      bind t set status

      # pane splitting
      unbind v
      unbind s
      unbind %
      unbind '"'

      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # pane navigation
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R

      # windows
      unbind n  #DEFAULT KEY: Move to next window
      unbind w  #DEFAULT KEY: change current window interactively

      bind n command-prompt "rename-window '%%'"
      bind w new-window -c "#{pane_current_path}"

      # copy mode
      unbind -T copy-mode-vi Space; #Default for begin-selection
      unbind -T copy-mode-vi Enter; #Default for copy-selection

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel --clipboard"
    '';
  };
}
