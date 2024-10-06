{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>op";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle neo-tree";
        };
      }
      {
        mode = "n";
        key = "<leader>oP";
        action = "<cmd>Neotree reveal<cr>";
        options = {
          noremap = true;
          silent = true;
          desc = "Reveal file in neo-tree";
        };
      }
    ];
  };
}
