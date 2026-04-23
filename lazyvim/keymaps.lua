vim.keymap.set("n", "<leader>ac", function()
  local screenshot = "/tmp/nvim_screenshot.png"
  vim.fn.system("screencapture -x " .. screenshot)
  Snacks.terminal.open(
    { 
      "claude", 
      "Screenshot of my current Neovim state: " .. screenshot .. "\nMy Neovim config is in this directory." 
    },
    {
      cwd = "~/Documents/Programming/nix/neovim",
      win = {
        position = "float",
        width = 0.38,
        height = 0.45,
        border = "rounded",
      },
    }
  )
 ggend, { desc = "Claude" })
