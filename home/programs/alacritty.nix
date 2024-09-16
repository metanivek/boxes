{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ alacritty-theme ];

  programs.alacritty = {
    enable = true;

    settings = {
      import = [ "${pkgs.alacritty-theme}/kanagawa_wave.toml" ];

      working_directory = config.home.homeDirectory;

      env = {
        TERM = "xterm-256color";
      };

      font = {
        size = 16;
        normal = {
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
