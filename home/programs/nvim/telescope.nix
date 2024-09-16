{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        fzf-native = {
          enable = true;
        };
        ui-select = {
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
        "<leader>cS" = "lsp_document_symbols";
        "<leader>cd" = "diagnostics";
        "<leader>pS" = "lsp_workspace_symbols";
      };
    };
  };
}
