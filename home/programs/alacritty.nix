{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ alacritty-theme ];

  programs.alacritty = {
    enable = true;

    settings = {
      # import = [ "${pkgs.alacritty-theme}/kanagawa_wave.toml" ];
      import = [ "${pkgs.alacritty-theme}/tomorrow_night_bright.toml" ];

      working_directory = config.home.homeDirectory;

      env = {
        TERM = "xterm-256color";
      };

      font = {
        size = 14;
        normal = {
          # family = "Iosevka Nerd Font Mono";
          family = "FiraCode Nerd Font Mono";
        };
      };

      selection = {
        save_to_clipboard = true;
      };

      window = {
        startup_mode = "Maximized";
        decorations = "None";

        position = {
          x = 0;
          y = 0;
        };

        padding = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
