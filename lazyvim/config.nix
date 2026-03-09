{ ... }:
{
  programs.lazyvim.config.options = ''
    vim.opt.spell = true
    vim.opt.autoread = true
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
  '';
}
