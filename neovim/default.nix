{ ... }:
{
  imports = [
    ./plugins/git.nix
    ./plugins/explorer.nix
    ./plugins/lsp.nix
    ./plugins/treesitter.nix
    ./plugins/completion.nix
    ./plugins/dap.nix
    ./plugins/testing.nix
    ./plugins/tasks.nix
    ./plugins/ui.nix
    ./plugins/editing.nix
    ./plugins/screenshot.nix
    ./plugins/telescope.nix
    ./plugins/terminal.nix
    ./plugins/formatting.nix
  ];

  globals.mapleader = " ";

  opts = {
    number = true;
    relativenumber = true;
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartindent = true;
    wrap = false;
    swapfile = false;
    backup = false;
    undofile = true;
    hlsearch = false;
    incsearch = true;
    termguicolors = true;
    scrolloff = 8;
    signcolumn = "yes";
    updatetime = 50;
  };
}
