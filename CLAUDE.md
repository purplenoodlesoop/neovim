# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

```bash
nix build .#default        # build the neovim derivation → ./result/bin/nvim
nix run .#default          # build and launch nvim directly
```

Run tools from the dev shell (gh, git) via direnv:

```bash
direnv allow               # one-time setup
direnv exec . gh <args>    # run any devShell tool without entering the shell
```

## Architecture

This is a pure-Nix Neovim configuration using [nixvim](https://github.com/nix-community/nixvim) on top of [purplenoodlesoop/core-flake](https://github.com/purplenoodlesoop/core-flake).

**No init.lua, no plugin manager** — everything is declared in Nix and built as a single derivation.

### core-flake API

`lib.evalFlake` accepts:
- `perSystem = { pkgs, ... }: { ... }` — per-system config
- `flake.packages.<name>` — exposed packages
- `flake.shell` — devShell tool list
- `tasks.<name>.body` — shell scripts exposed as `nix run .#<task>` (supports `${pkgs.foo}/bin/foo` interpolation)
- `nixosModules.tasks` must be imported for tasks to work

### Module structure

```
neovim/default.nix          # root nixvim module; sets globals.mapleader, opts, imports all plugins
neovim/plugins/
  git.nix                   # gitsigns, neogit, diffview
  explorer.nix              # neo-tree, oil
  lsp.nix                   # dartls, nixd, ts_ls, ltex, yamlls, jsonls, lemminx, flutter-tools, schemastore
  treesitter.nix            # all grammars via nixGrammars = true
  completion.nix            # nvim-cmp + luasnip (autoEnableSources = true)
  dap.nix                   # nvim-dap, dap-ui, dap-virtual-text
  testing.nix               # neotest + neotest-dart adapter
  tasks.nix                 # overseer
  ui.nix                    # tokyonight moon, lualine, bufferline, noice, notify, cursorline, indent-blankline, rainbow-delimiters
  editing.nix               # which-key, autopairs, comment, todo-comments, trouble
  screenshot.nix            # nvim-silicon via extraPlugins (no native nixvim module)
  telescope.nix             # telescope + fzf-native
  terminal.nix              # toggleterm with Claude Code and lazygit float terminals
  formatting.nix            # conform-nvim (nixfmt, prettier, stylua) with absolute pkgs paths
```

### nixvim conventions used here

- Colorschemes live under `colorschemes.<name>`, not `plugins.<name>`
- neo-tree config uses `settings.*` namespace (e.g. `settings.window.width`)
- `nixGrammars = true` with no `grammarPackages` → nixvim manages all treesitter grammars
- Plugins without native nixvim support use `extraPlugins = [ pkgs.vimPlugins.* ]` + `extraConfigLua`
- cmp keymaps use `mapping.__raw = "cmp.mapping.preset.insert({...})"` for Lua blocks
- DAP keymaps: `action.__raw = "function() ... end"` for Lua; plain `action = "<cmd>..."` for vim strings
- Formatter binaries reference `${pkgs.tool}/bin/tool` directly to avoid PATH issues
