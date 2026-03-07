{ ... }:
{
  plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    settings = {
      defaults = {
        layout_strategy = "horizontal";
        sorting_strategy = "ascending";
        layout_config = {
          horizontal = {
            prompt_position = "top";
            preview_width = 0.55;
          };
        };
        mappings.i = {
          "<C-k>".__raw = "require('telescope.actions').move_selection_previous";
          "<C-j>".__raw = "require('telescope.actions').move_selection_next";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options.desc = "Telescope find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<cr>";
      options.desc = "Telescope live grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<cr>";
      options.desc = "Telescope buffers";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<cr>";
      options.desc = "Telescope help tags";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>Telescope oldfiles<cr>";
      options.desc = "Telescope recent files";
    }
    {
      mode = "n";
      key = "<leader>fd";
      action = "<cmd>Telescope diagnostics<cr>";
      options.desc = "Telescope diagnostics";
    }
  ];
}
