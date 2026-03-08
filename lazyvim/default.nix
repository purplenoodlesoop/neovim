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
      lang = {
        nix = {
          enable = true;
          installDependencies = true;
        };
        dart.enable = true;
        haskell.enable = true;
        typescript = {
          enable = true;
          installDependencies = true;
        };
        markdown.enable = true;
        yaml = {
          enable = true;
          installDependencies = true;
        };
        json.enable = true;
        sql.enable = true;
        git.enable = true;
      };
      editor = {
        neo_tree.enable = true;
        overseer.enable = true;
      };
      dap.core.enable = true;
      test.core.enable = true;
      ui.indent_blankline.enable = true;
      formatting.prettier.enable = true;
    };
  };
}
