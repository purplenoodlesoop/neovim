{ ... }:
{
  programs.lazyvim.plugins = {

    theme = ''
      return {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        opts = {
          italic_comments = true,
          hide_fillchars = true,
          terminal_colors = true,
          theme = { variant = "default" },
        },
        config = function(_, opts)
          require("cyberdream").setup(opts)
          vim.cmd("colorscheme cyberdream")
        end,
      }
    '';

    flutter = ''
      return {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
          "nvim-lua/plenary.nvim",
          "stevearc/dressing.nvim",
        },
        opts = {
          debugger = {
            enabled = true,
            run_via_dap = true,
            exception_breakpoints = {},
          },
          flutter_lookup_cmd = nil,
          fvm = false,
          widget_guides = { enabled = true },
          closing_tags = {
            highlight = "ErrorMsg",
            prefix = "//",
            enabled = true,
          },
          dev_log = { enabled = true, notify_errors = false, open_cmd = "tabedit" },
          lsp = {
            color = { enabled = true },
            settings = {
              completeFunctionCalls = true,
              renameFilesWithClasses = "prompt",
              enableSdkFormatter = true,
              updateImportsOnRename = true,
              documentation = "full",
              includeDependenciesInWorkspaceSymbols = true,
            },
          },
        },
        config = function(_, opts)
          require("flutter-tools").setup(opts)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.dart",
            callback = function()
              pcall(vim.cmd, "FlutterHotReload")
            end,
            desc = "Flutter hot reload on save",
          })
        end,
      }
    '';

    rainbow = ''
      return {
        "HiPhish/rainbow-delimiters.nvim",
        event = "BufReadPost",
        config = function()
          local rainbow = require("rainbow-delimiters")
          require("rainbow-delimiters.setup").setup({
            strategy = {
              [""] = rainbow.strategy["global"],
            },
            query = {
              [""] = "rainbow-delimiters",
              lua = "rainbow-blocks",
            },
            highlight = {
              "RainbowDelimiterRed",
              "RainbowDelimiterYellow",
              "RainbowDelimiterBlue",
              "RainbowDelimiterOrange",
              "RainbowDelimiterGreen",
              "RainbowDelimiterViolet",
              "RainbowDelimiterCyan",
            },
          })
        end,
      }
    '';

    screenshot = ''
      return {
        "michaelrommel/nvim-silicon",
        cmd = "Silicon",
        opts = {
          output = function()
            return "~/silicon-" .. os.date("!%Y-%m-%dT%H:%M:%S") .. ".png"
          end,
          background = "#FFFFFF",
          shadow_blur_radius = 0,
          shadow_offset_x = 0,
          shadow_offset_y = 0,
          pad_horiz = 80,
          pad_vert = 100,
          line_number = true,
          round_corner = true,
        },
      }
    '';

  };
}
