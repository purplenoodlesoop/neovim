{ ... }:
{
  plugins.toggleterm = {
    enable = true;
    settings = {
      size = 20;
      open_mapping = null;
      hide_numbers = true;
      shade_terminals = true;
      shading_factor = 2;
      start_in_insert = true;
      insert_mappings = true;
      persist_size = true;
      direction = "float";
      close_on_exit = true;
      shell = "zsh";
      float_opts = {
        border = "curved";
        winblend = 0;
      };
    };
  };

  extraConfigLua = ''
    local Terminal = require("toggleterm.terminal").Terminal

    local claude_term = Terminal:new({
      cmd = "claude",
      display_name = "Claude Code",
      direction = "float",
      float_opts = { border = "curved" },
      hidden = true,
    })

    local lazygit_term = Terminal:new({
      cmd = "lazygit",
      display_name = "Lazygit",
      direction = "float",
      float_opts = { border = "curved" },
      hidden = true,
    })

    function _CLAUDE_TOGGLE()
      claude_term:toggle()
    end

    function _LAZYGIT_TOGGLE()
      lazygit_term:toggle()
    end
  '';

  keymaps = [
    {
      mode = [
        "n"
        "t"
      ];
      key = "<leader>tt";
      action = "<cmd>lua _CLAUDE_TOGGLE()<cr>";
      options.desc = "Toggle Claude Code terminal";
    }
    {
      mode = [
        "n"
        "t"
      ];
      key = "<leader>tg";
      action = "<cmd>lua _LAZYGIT_TOGGLE()<cr>";
      options.desc = "Toggle Lazygit terminal";
    }
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Terminal normal mode";
    }
  ];
}
