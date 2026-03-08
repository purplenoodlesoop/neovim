{ pkgs, ... }:
{
  imports = [
    ./plugins.nix
    ./config.nix
  ];

  programs.lazyvim = {
    enable = true;
    installCoreDependencies = true;

    extraPackages = with pkgs; [
      silicon
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      xml
    ];

    extras = {
      lang.nix = {
        enable = true;
        installDependencies = true;
      };
      lang.dart = {
        enable = true;
      };
      lang.haskell = {
        enable = true;
      };
      lang.typescript = {
        enable = true;
        installDependencies = true;
      };
      lang.markdown = {
        enable = true;
      };
      lang.yaml = {
        enable = true;
        installDependencies = true;
      };
      lang.json = {
        enable = true;
      };
      lang.sql = {
        enable = true;
      };
      lang.git = {
        enable = true;
      };
      dap.core = {
        enable = true;
      };
      test.core = {
        enable = true;
      };
      editor.neo_tree = {
        enable = true;
      };
      editor.overseer = {
        enable = true;
      };
      ui.indent_blankline = {
        enable = true;
      };
      formatting.prettier = {
        enable = true;
      };
    };
  };
}
