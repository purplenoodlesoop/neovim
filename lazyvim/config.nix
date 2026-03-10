{ ... }:
{
  programs.lazyvim.config.options = ''
    vim.opt.spell = true
    vim.opt.autoread = true
    vim.opt.number = true
    vim.opt.relativenumber = true
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
