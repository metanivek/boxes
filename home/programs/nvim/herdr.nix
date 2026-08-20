{ inputs, pkgs, ... }:
let
  herdrNvimPlugin = pkgs.vimUtils.buildVimPlugin {
    pname = "herdr-nvim";
    version = "0.1.1";
    src = inputs.herdr-nvim;
  };
in
{
  programs.nixvim = {
    extraPlugins = [ herdrNvimPlugin ];

    extraConfigLua = ''
      require("herdr-nvim").setup({})
    '';
  };
}
