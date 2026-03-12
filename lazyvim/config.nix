{ config, ... }:
{
  programs.lazyvim.config.keymaps = ''
    vim.keymap.set("n", "<leader>ac", function()
      local screenshot = "/tmp/nvim_screenshot.png"
      vim.fn.system("screencapture -x " .. screenshot)
      Snacks.terminal.open(
        { "claude", "Screenshot of my current Neovim state: " .. screenshot .. "\nMy Neovim config is in this directory." },
        {
          cwd = "${config.home.homeDirectory}/Documents/Programming/nix/neovim",
          win = {
            position = "float",
            width = 0.38,
            height = 0.45,
            border = "rounded",
          },
        }
      )
    end, { desc = "Claude" })
  '';

  programs.lazyvim.config.options = ''
    vim.opt.spell = true
    vim.opt.autoread = true
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.shortmess:remove("S")
  '';

  programs.lazyvim.config.autocmds = ''
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
      pattern = "*",
      callback = function()
        if vim.fn.mode() ~= "c" then
          vim.cmd("checktime")
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
      callback = function()
        if vim.bo.buftype == "" then
          vim.opt_local.statuscolumn = "%C%s%=%{v:relnum}  %{v:lnum} "
        else
          vim.opt_local.statuscolumn = ""
        end
      end,
    })

    vim.g.workspace_diag_errors = 0
    vim.g.workspace_diag_warnings = 0
    vim.api.nvim_create_autocmd("DiagnosticChanged", {
      callback = function()
        local counts = { 0, 0, 0, 0 }
        for _, d in ipairs(vim.diagnostic.get(nil)) do
          if d.severity then
            counts[d.severity] = (counts[d.severity] or 0) + 1
          end
        end
        vim.g.workspace_diag_errors = counts[1] or 0
        vim.g.workspace_diag_warnings = counts[2] or 0
      end,
    })

    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "FocusGained" }, {
      pattern = "*",
      callback = function()
        local ok, manager = pcall(require, "neo-tree.sources.manager")
        if ok then
          manager.refresh("filesystem")
        end
      end,
    })
  '';
}
