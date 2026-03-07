{ ... }:
{
  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add.text = "│";
          change.text = "│";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
        };
        current_line_blame = true;
      };
    };

    neogit = {
      enable = true;
      settings.integrations.diffview = true;
    };

    diffview.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>gs";
      action = "<cmd>Neogit<cr>";
      options.desc = "Neogit";
    }
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>DiffviewOpen<cr>";
      options.desc = "DiffviewOpen";
    }
    {
      mode = "n";
      key = "<leader>gD";
      action = "<cmd>DiffviewClose<cr>";
      options.desc = "DiffviewClose";
    }
  ];
}
