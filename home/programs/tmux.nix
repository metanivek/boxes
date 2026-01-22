{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    tmuxp.enable = true;
    prefix = "C-Space";
    escapeTime = 10;
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
        plugin = session-wizard;
        extraConfig = ''
          set -g @session-wizard S
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
      set-option -g status-style 'fg=white bg=black'
      set-option -g window-status-current-style 'fg=green bg=black'
      set-option -g status-right "%H:%M"

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
