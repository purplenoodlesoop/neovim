{ ... }:
{
  programs.lazyvim.plugins = {

    lualine = ''
      return {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
          opts.sections = opts.sections or {}
          opts.sections.lualine_y = opts.sections.lualine_y or {}
          table.insert(opts.sections.lualine_y, 1, {
            function()
              local e = vim.g.workspace_diag_errors or 0
              local w = vim.g.workspace_diag_warnings or 0
              if e == 0 and w == 0 then return "" end
              local icons = LazyVim.config.icons.diagnostics
              local parts = {}
              if e > 0 then table.insert(parts, icons.Error .. e) end
              if w > 0 then table.insert(parts, icons.Warn .. w) end
              return table.concat(parts, " ")
            end,
            color = function()
              local e = vim.g.workspace_diag_errors or 0
              if e > 0 then return { fg = Snacks.util.color("DiagnosticError") } end
              return { fg = Snacks.util.color("DiagnosticWarn") }
            end,
          })
          return opts
        end,
      }
    '';

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
          require("silkcircuit").setup({
            integrations = {
              lualine = false,
              gitsigns = false,
              indent_blankline = false,
              bufferline = false,
              noice = false,
              notify = false,
            },
          })
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
          vim.keymap.set("n", "<leader>um", MiniMap.toggle, { desc = "Toggle Minimap" })
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

    dart-lsp = ''
      return {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
          -- flutter-tools.nvim owns the dartls client (closing tags, outline,
          -- hot reload, dev tools). Stop LazyVim's lang.dart extra from starting
          -- a second generic dartls, which would double up diagnostics,
          -- completions and inlay hints. LSP keymaps still attach to the
          -- flutter-tools client via LazyVim's global on-attach.
          opts.servers = opts.servers or {}
          opts.servers.dartls = opts.servers.dartls or {}
          opts.servers.dartls.enabled = false

          -- Keep dart buffers free of inlay hints by default (reveal via
          -- <leader>uh). dartls exposes no per-kind hint toggle, so exclude
          -- the whole filetype.
          opts.inlay_hints = opts.inlay_hints or {}
          opts.inlay_hints.exclude = opts.inlay_hints.exclude or {}
          table.insert(opts.inlay_hints.exclude, "dart")

          return opts
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
            condition = function(bufnr)
              return vim.bo[bufnr].buftype == ""
            end,
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
