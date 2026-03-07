{ ... }:
{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        dartls.enable = true;
        nixd.enable = true;
        ts_ls.enable = true;
        ltex.enable = true;
        yamlls = {
          enable = true;
          settings.yaml = {
            schemas.__raw = "require('schemastore').yaml.schemas()";
            validate = true;
          };
        };
        jsonls = {
          enable = true;
          settings.json = {
            schemas.__raw = "require('schemastore').json.schemas()";
            validate.enable = true;
          };
        };
        lemminx.enable = true;
      };
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "gr" = "references";
          "gI" = "implementation";
          "gy" = "type_definition";
          "K" = "hover";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
          "<leader>f" = "format";
        };
        diagnostic = {
          "<leader>d" = "open_float";
          "[d" = "goto_prev";
          "]d" = "goto_next";
          "<leader>q" = "setloclist";
        };
      };
    };

    schemastore.enable = true;

    flutter-tools = {
      enable = true;
      settings = {
        debugger = {
          enabled = true;
          run_via_dap = true;
        };
        flutter_lookup_cmd = null;
        fvm = false;
        widget_guides.enabled = true;
        closing_tags.enabled = true;
      };
    };
  };
}
