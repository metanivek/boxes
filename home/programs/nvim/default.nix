{ pkgs, ... }:
{
  imports = [
    ./colorscheme.nix
    ./copilot.nix
    ./cmp.nix
    ./git.nix
    ./keymaps.nix
    ./neo-tree.nix
    ./projects.nix
    ./lint.nix
    ./lsp.nix
    ./lualine.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
    };

    plugins.alpha = {
      enable = true;
      theme = "startify";
    };
    plugins.bufdelete.enable = true;
    plugins.comment.enable = true;
    plugins.cursorline = {
      enable = true;
      # cursorline.timeout = 0;
    };
    plugins.marks.enable = true;
    plugins.vim-surround.enable = true;
    plugins.web-devicons.enable = true;
    plugins.zen-mode.enable = true;

    opts = {
      autoindent = true;
      background = "dark";
      backup = false;
      breakindent = true;
      clipboard = "unnamedplus";
      completeopt = "menuone,noselect";
      conceallevel = 0;
      cmdheight = 0;
      expandtab = true;
      fileencodings = "utf-8";
      hlsearch = true;
      ignorecase = true;
      inccommand = "split";
      linebreak = true;
      number = true;
      numberwidth = 2;
      relativenumber = true;
      # scrolloff = 999;
      shiftwidth = 2;
      signcolumn = "yes";
      softtabstop = 2;
      smartindent = true;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      termguicolors = true;
      undofile = true;
      updatetime = 250;
      virtualedit = "block";
      wrap = false;
      writebackup = false;
    };
  };
}
