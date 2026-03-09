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
