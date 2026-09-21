{ config, pkgs, ... }:
{
  # Russian spell dictionary, pinned instead of nvim's runtime download
  # prompt. Keeps `spell = true` useful in mixed en/ru notes.
  xdg.configFile = {
    "nvim/spell/ru.utf-8.spl".source = pkgs.fetchurl {
      url = "https://ftp.nluug.nl/pub/vim/runtime/spell/ru.utf-8.spl";
      sha256 = "0kf5vbk7lmwap1k4y4c1fm17myzbmjyzwz0arh5v6810ibbknbgb";
    };
    "nvim/spell/ru.utf-8.sug".source = pkgs.fetchurl {
      url = "https://ftp.nluug.nl/pub/vim/runtime/spell/ru.utf-8.sug";
      sha256 = "0frrdxhp37f8xi4wp6f2mxs07arbk3vqr038h3xmnpfqi8b8dgga";
    };
  };

  programs.lazyvim.config.keymaps = ''
    vim.keymap.set("n", "<leader>ac", function()
      local screenshot = "/tmp/nvim_screenshot.png"
      vim.fn.system("screencapture -x " .. screenshot)
      local msg = "My current Neovim state is shown in the attached screenshot. My Neovim config is in this directory."
      local cmd = "opencode run -f " .. vim.fn.shellescape(screenshot) .. " -- " .. vim.fn.shellescape(msg) .. " && opencode --continue"
      Snacks.terminal.open(
        { "bash", "-c", cmd },
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
    end, { desc = "Opencode" })
  '';

  programs.lazyvim.config.options = ''
    vim.opt.spell = true
    vim.opt.spelllang = { "en", "ru" }
    vim.opt.autoread = true
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.shortmess:remove("S")
    vim.opt.wrap = true
    vim.opt.linebreak = true
  '';

  programs.lazyvim.config.autocmds = ''
    -- Obsidian-style list continuation. nvim's markdown ftplugin opts out of
    -- this deliberately (formatoptions-=ro, and fb: leaders that apply to the
    -- first line only), so put it back per buffer. The checkbox leader has to
    -- come first: 'comments' uses the first entry that matches.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.comments = { "b:- [ ]", "b:*", "b:-", "b:+", "n:>" }
        vim.opt_local.formatoptions:append("ro")
      end,
      desc = "Continue markdown lists on <CR> and o/O",
    })

    -- Autosave notes whenever focus leaves the buffer, the window or nvim
    -- itself. Markdown only: elsewhere this would fire format-on-save on every
    -- buffer switch. Pairs with the checktime autocmd below, which pulls in
    -- edits made to the same note from Obsidian or another client.
    vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "WinLeave" }, {
      callback = function(ev)
        local bo = vim.bo[ev.buf]
        if bo.filetype ~= "markdown" or bo.buftype ~= "" then
          return
        end
        if not bo.modified or not bo.modifiable or bo.readonly then
          return
        end
        if vim.api.nvim_buf_get_name(ev.buf) == "" then
          return
        end
        vim.api.nvim_buf_call(ev.buf, function()
          vim.cmd("silent! write")
        end)
      end,
      desc = "Autosave markdown on focus change",
    })

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

    -- ~/eved is a read-only mirror of the assistant's memory, rewritten by git
    -- whenever the host commits. Watch it, and reload whatever is open from it
    -- the moment it changes, not only when focus or the cursor moves.
    do
      local root = "${config.home.homeDirectory}/eved"
      if vim.uv.fs_stat(root) then
        local watcher = vim.uv.new_fs_event()
        local pending = false
        watcher:start(root, { recursive = true }, function()
          if pending then
            return
          end
          pending = true
          -- A sync touches many files at once; settle, then reload once.
          vim.defer_fn(function()
            pending = false
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(buf) and vim.startswith(vim.api.nvim_buf_get_name(buf), root .. "/") then
                vim.cmd("checktime " .. buf)
              end
            end
          end, 200)
        end)
      end
    end
  '';
}
