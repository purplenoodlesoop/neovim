{ pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 500;
      };
      formatters_by_ft = {
        nix = [ "nixfmt" ];
        javascript = [ "prettier" ];
        typescript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        json = [ "prettier" ];
        yaml = [ "prettier" ];
        markdown = [ "prettier" ];
        html = [ "prettier" ];
        css = [ "prettier" ];
        lua = [ "stylua" ];
      };
      formatters = {
        nixfmt.command = "${pkgs.nixfmt}/bin/nixfmt";
        prettier.command = "${pkgs.nodePackages.prettier}/bin/prettier";
        stylua.command = "${pkgs.stylua}/bin/stylua";
      };
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>mp";
      action.__raw = "function() require('conform').format({ async = true, lsp_fallback = true }) end";
      options.desc = "Format buffer";
    }
  ];
}
