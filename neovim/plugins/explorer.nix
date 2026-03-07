{ ... }:
{
  plugins = {
    neo-tree = {
      enable = true;
      settings = {
        window.width = 35;
        filesystem = {
          follow_current_file.enabled = true;
          filtered_items = {
            hide_hidden = false;
            hide_dotfiles = false;
          };
        };
      };
    };

    oil = {
      enable = true;
      settings.defaultFileExplorer = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree toggle<cr>";
      options.desc = "Toggle Neo-tree";
    }
    {
      mode = "n";
      key = "<leader>-";
      action = "<cmd>Oil<cr>";
      options.desc = "Open Oil (dir buffer)";
    }
  ];
}
