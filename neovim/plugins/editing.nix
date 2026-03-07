{ ... }:
{
  plugins = {
    which-key = {
      enable = true;
      settings = {
        delay = 500;
        icons.mappings = true;
      };
    };

    nvim-autopairs = {
      enable = true;
      settings.check_ts = true;
    };

    comment.enable = true;

    todo-comments = {
      enable = true;
      settings = {
        signs = true;
        keywords = {
          TODO = { icon = " "; color = "info"; };
          HACK = { icon = " "; color = "warning"; };
          WARN = { icon = " "; color = "warning"; };
          NOTE = { icon = " "; color = "hint"; };
          FIX = { icon = " "; color = "error"; };
        };
      };
    };

    trouble = {
      enable = true;
      settings = {
        position = "bottom";
        auto_close = true;
        use_diagnostic_signs = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>TroubleToggle<cr>";
      options.desc = "Trouble toggle";
    }
    {
      mode = "n";
      key = "<leader>xw";
      action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
      options.desc = "Trouble workspace diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xd";
      action = "<cmd>TroubleToggle document_diagnostics<cr>";
      options.desc = "Trouble document diagnostics";
    }
    {
      mode = "n";
      key = "<leader>td";
      action = "<cmd>TodoTrouble<cr>";
      options.desc = "Todo (Trouble)";
    }
  ];
}
