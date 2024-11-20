{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        fzf-native = {
          enable = true;
        };
        ui-select = {
          enable = true;
          settings = {
            specific_opts = {
              codeactions = true;
            };
          };
        };
        undo = {
          enable = true;
          settings = {
            use_delta = true;
          };
        };
      };

      # close telescope with esc -- don't just to normal mode
      settings = {
        defaults = {
          mappings = {
            i = {
              "<esc>" = {
                __raw = ''
                  function(...)
                    return require("telescope.actions").close(...)
                  end'';
              };
            };
          };
        };
      };

      keymaps = {
        "<leader>sp" = "live_grep";
        "<leader>ss" = "current_buffer_fuzzy_find";
        "<leader>/" = "live_grep";
        "<leader>pf" = "find_files";
        "<leader>bb" = "buffers";
        "<leader>kk" = "commands";
        "<leader>cd" = "diagnostics";
      };
    };

    keymaps = [
      {
        key = "<leader>sd";
        action.__raw = ''
          function()
            local cwd = vim.fn.expand("%:h")
            require("telescope.builtin").live_grep({cwd = cwd})
          end
        '';
        mode = "n";
        options = {
          noremap = true;
          silent = true;
          desc = "Search current directory";
        };
      }
      {
        key = "<leader>fd";
        action.__raw = ''
          function()
            local cwd = vim.fn.expand("%:h")
            require("telescope.builtin").find_files({cwd = cwd})
          end
        '';
        mode = "n";
        options = {
          noremap = true;
          silent = true;
          desc = "Find files in current directory";
        };
      }
    ];
  };
}
