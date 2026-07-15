{ pkgs, ... }:
{
  imports = [
    ./plugins.nix
    ./config.nix
  ];

  programs.lazyvim = {
    enable = true;
    installCoreDependencies = true;
    ignoreBuildNotifications = true;

    extraPackages = with pkgs; [
      silicon
      vscode-js-debug
      typescript-language-server
      statix
      yaml-language-server
      nixd
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      xml
      ruby # Podfile / Fastfile / Gemfile highlighting + rainbow-delimiters
    ];

    extras = {
      lang = {
        nix = {
          enable = true;
          installDependencies = true;
          config = ''
            return {
              "neovim/nvim-lspconfig",
              opts = {
                servers = {
                  nixd = {},
                },
              },
            }
          '';
        };
        dart.enable = true;
        haskell.enable = true;
        typescript = {
          enable = true;
          installDependencies = false;
        };
        markdown = {
          enable = true;
          installDependencies = true;
        };
        yaml = {
          enable = true;
          installDependencies = true;
        };
        json.enable = true;
        sql.enable = true;
        git.enable = true;
      };
      editor = {
        "neo-tree" = {
          enable = true;
          config = ''
            return {
              "nvim-neo-tree/neo-tree.nvim",
              opts = {
                filesystem = {
                  use_libuv_file_watcher = true,
                  filtered_items = {
                    visible = true,
                  },
                },
              },
            }
          '';
        };
        overseer.enable = true;
      };
      ai.copilot.enable = true;
      dap.core.enable = true;
      test.core.enable = true;
      ui."indent-blankline".enable = true;
      formatting.prettier.enable = true;
    };
  };
}
