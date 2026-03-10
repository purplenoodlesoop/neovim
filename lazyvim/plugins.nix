{ ... }:
{
  programs.lazyvim.plugins = {

    snacks = ''
      return {
        "folke/snacks.nvim",
        opts = {
          statuscolumn = { enabled = false },
        },
      }
    '';

    diffview = ''
      return {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
      }
    '';

    markdown-preview = ''
      return {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
      }
    '';

    theme = ''
      return {
        "hyperb1iss/silkcircuit-nvim",
        lazy = false,
        priority = 1000,
        config = function()
          require("silkcircuit").setup({})
          vim.cmd("colorscheme silkcircuit")
        end,
      }
    '';

    minimap = ''
      return {
        "nvim-mini/mini.map",
        version = "*",
        event = "BufReadPost",
        config = function()
          local map = require("mini.map")
          map.setup({
            integrations = {
              map.gen_integration.builtin_search(),
              map.gen_integration.diagnostic(),
              map.gen_integration.gitsigns(),
            },
            symbols = {
              encode = map.gen_encode_symbols.dot("4x2"),
            },
            window = {
              side = "right",
              width = 10,
              winblend = 15,
              show_integration_count = false,
            },
          })
          vim.api.nvim_create_autocmd("BufWinEnter", {
            callback = function()
              local ft = vim.bo.filetype
              local excluded = { "neo-tree", "lazy", "mason", "TelescopePrompt", "help", "toggleterm" }
              for _, v in ipairs(excluded) do
                if ft == v then return end
              end
              MiniMap.open()
            end,
          })
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
