{
  programs.nixvim = {
    plugins.project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        use_lsp = false;
        patterns = [ ".git" ];
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>pp";
        action.__raw = ''
          function ()
            require("telescope").extensions.projects.projects({})
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Switch project";
        };
      }
    ];
  };
}
