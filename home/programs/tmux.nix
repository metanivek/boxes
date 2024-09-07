{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    tmuxp.enable = true;
    prefix = "C-Space";
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    historyLimit = 100000;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    plugins = with pkgs; [ tmuxPlugins.extrakto ];
    extraConfig = ''
      # --------------------------------- #
      # extra config                      #
      # --------------------------------- #

      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set-option -g status-position bottom
      set-option -g status-style "bg=color0,fg=color7"
      set-window-option -g window-status-current-style "bg=color6,fg=color0"
      set-option -g pane-border-style "fg=color0,bg=color0"
      set-option -g pane-active-border-style "fg=color7,bg=color0"
      set -g window-status-format " #I #W "
      set -g window-status-current-format " #I #W* "
      set -g status-left ' '
      set -g status-right ' %H:%M '

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
