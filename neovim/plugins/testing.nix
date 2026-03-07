{ ... }:
{
  plugins.neotest = {
    enable = true;
    adapters.dart.enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>nt";
      action.__raw = "function() require('neotest').run.run() end";
      options.desc = "Neotest run nearest";
    }
    {
      mode = "n";
      key = "<leader>nT";
      action.__raw = "function() require('neotest').run.run(vim.fn.expand('%')) end";
      options.desc = "Neotest run file";
    }
    {
      mode = "n";
      key = "<leader>ns";
      action.__raw = "function() require('neotest').summary.toggle() end";
      options.desc = "Neotest summary";
    }
    {
      mode = "n";
      key = "<leader>no";
      action.__raw = "function() require('neotest').output.open({ enter = true }) end";
      options.desc = "Neotest output";
    }
  ];
}
