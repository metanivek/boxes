{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;

      servers = {
        dockerls.enable = true;
        # efm.enable = true; # general purpose language server
        elmls.enable = true;
        gleam.enable = true;
        gopls.enable = true;
        graphql.enable = true;
        hls = {
          enable = true;
          installGhc = false; # set to true to install ghc automatically
        };
        # jedi_language_server.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nil_ls = {
          enable = true;
          settings.formatting.command = [ "nixfmt" ];
        };
        lua_ls.enable = true;
        # ocamllsp.enable = true;
        pyright.enable = true;
        ts_ls.enable = true;
        ruff.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        # vuels.enable = true;
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

    plugins.telescope.keymaps = {
      "<leader>cS" = "lsp_document_symbols";
      "<leader>ci" = "lsp_implementations";
      "<leader>cD" = "lsp_definitions";
      "<leader>cr" = "lsp_references";
      "<leader>ct" = "lsp_type_definitions";
      "<leader>cic" = "lsp_incoming_calls";
      "<leader>coc" = "lsp_outgoing_calls";
      "<leader>pS" = "lsp_workspace_symbols";
    };

    plugins.lsp-format = {
      enable = true;
    };

    plugins.none-ls = {
      enable = true;
    };

    keymaps = [
      {
        key = "<leader>od";
        action.__raw = ''
          function ()
            vim.diagnostic.enable(not vim.diagnostic.is_enabled())
          end
        '';
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle diagnostics";
        };
      }
    ];
  };
}
