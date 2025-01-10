{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        integrations = {
          gitsigns = true;
          native_lsp.enabled = true;
          telescope = true;
          treesitter = true;
          which_key = true;
        };
      };
    };

    plugins.lualine.settings.options = {
      theme = "catppuccin";
    };
  };
}
