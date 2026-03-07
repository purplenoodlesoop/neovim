{ ... }:
{
  plugins.overseer = {
    enable = true;
    settings = {
      task_list = {
        direction = "bottom";
        min_height = 15;
        max_height = 15;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>or";
      action = "<cmd>OverseerRun<cr>";
      options.desc = "Overseer run task";
    }
    {
      mode = "n";
      key = "<leader>ot";
      action = "<cmd>OverseerToggle<cr>";
      options.desc = "Overseer toggle";
    }
    {
      mode = "n";
      key = "<leader>ol";
      action = "<cmd>OverseerLoadBundle<cr>";
      options.desc = "Overseer load bundle";
    }
  ];
}
