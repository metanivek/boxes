{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      servers = {
        dockerls.enable = true;
        efm.enable = true;
        elmls.enable = true;
        gleam.enable = true;
        gopls.enable = true;
        graphql.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nil-ls = {
          enable = true;
          settings.formatting.command = [ "nixfmt" ];
        };
        lua-ls.enable = true;
        pyright.enable = true;
        tsserver.enable = true;
        ruff-lsp.enable = true;
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        vuels.enable = true;
        yamlls.enable = true;
      };

      inlayHints = true;

      onAttach = ''
        -- Auto-format on save {{{
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        -- }}}
      '';
    };

    plugins.lsp-format = {
      enable = true;
    };

    plugins.none-ls = {
      enable = true;
    };
  };
}
