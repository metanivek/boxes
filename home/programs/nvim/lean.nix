{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      lean-nvim
    ];

    extraConfigLua = ''
      require("lean").setup({
        mappings = true,
      })
    '';
  };
}
