{
  programs.nixvim = {
    plugins.project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        #detection_methods = [ "lsp" "pattern" ];
        detection_methods = [ "pattern" ];
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
