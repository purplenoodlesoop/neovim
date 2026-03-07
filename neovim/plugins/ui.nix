{ ... }:
{
  colorschemes.tokyonight = {
    enable = true;
    settings = {
      style = "moon";
      transparent = false;
      terminal_colors = true;
      styles = {
        comments.italic = true;
        keywords.italic = true;
      };
    };
  };

  plugins = {
    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "tokyonight";
          globalstatus = true;
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "branch" "diff" "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "encoding" "fileformat" "filetype" ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };

    bufferline = {
      enable = true;
      settings.options = {
        diagnostics = "nvim_lsp";
        separator_style = "slant";
        show_buffer_close_icons = true;
        show_close_icon = false;
      };
    };

    noice = {
      enable = true;
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = false;
          lsp_doc_border = true;
        };
      };
    };

    notify = {
      enable = true;
      settings.background_colour = "#000000";
    };

    cursorline = {
      enable = true;
      settings = {
        cursorline = {
          enable = true;
          timeout = 1000;
        };
        cursorword = {
          enable = true;
          min_length = 3;
          hl.underline = true;
        };
      };
    };

    indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        scope = {
          enabled = true;
          show_start = true;
        };
      };
    };

    rainbow-delimiters.enable = true;

    web-devicons.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Prev buffer";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<cr>";
      options.desc = "Delete buffer";
    }
  ];
}
