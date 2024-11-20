{
  programs.nixvim = {
    plugins.copilot-vim.enable = true;
    plugins.copilot-chat.enable = true;

    extraConfigLua = ''
      vim.keymap.set('i', '<C-A>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    '';
  };
}