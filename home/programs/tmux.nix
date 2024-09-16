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
        plugin = mkTmuxPlugin {
          pluginName = "kanagawa";
          version = "unstable-2024-07-06";
          src = pkgs.fetchFromGitHub {
            owner = "Nybkox";
            repo = "tmux-kanagawa";
            rev = "fc95d797ba24536bffe3f2b2101e7d7ec3e5aaa1";
            sha256 = "1d00hhsjv8s00f5a722xpbvzs9780zp55hqzkc0fkapvnig2la5w";
          };
        };
        extraConfig = ''
          set -g @kanagawa-left-icon session
          set -g @kanagawa-show-flags true
          set -g @kanagawa-show-location false
          set -g @kanagawa-time-format "%H:%M"
          set -g @kanagawa-plugins "battery cpu time"
          set -g @kanagawa-show-powerline true
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
