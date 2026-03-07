# neovim

A fully declarative Neovim configuration built with [nixvim](https://github.com/nix-community/nixvim) on top of [purplenoodlesoop/core-flake](https://github.com/purplenoodlesoop/core-flake). No `init.lua`, no plugin manager — every plugin, LSP server, formatter, and keymap is declared in Nix and built as a single reproducible derivation.

## Philosophy

- **Pure Nix** — the entire editor is a Nix package. `nix build` produces a self-contained `nvim` binary with all plugins and tools baked in.
- **Reproducible** — the same `flake.lock` produces the exact same editor on any machine.
- **No runtime plugin management** — no lazy.nvim, no packer. Plugins are managed by Nix at build time.

## Quick Start

```bash
# Build and run
nix build .#default
./result/bin/nvim /path/to/project

# Or directly
nix run .#default -- /path/to/project
```

## Features

### Theme

[Tokyo Night](https://github.com/folke/tokyonight.nvim) **moon** variant — a purple-toned dark theme with italic comments and keywords.

### Language Support

| Language | LSP Server | Notes |
|---|---|---|
| Dart / Flutter | `dartls` + `flutter-tools` | Debugger, widget guides, closing tags |
| Nix | `nixd` | Expression-aware completion |
| TypeScript / JavaScript | `ts_ls` | |
| Prose / LaTeX | `ltex` | Grammar checking |
| YAML | `yamlls` + SchemaStore | Auto schema detection |
| JSON | `jsonls` + SchemaStore | Auto schema detection |
| XML | `lemminx` | |
| All others | treesitter | Syntax highlighting + indentation |

### Plugins

| Category | Plugins |
|---|---|
| **Git** | gitsigns (inline blame + signs), neogit (full TUI), diffview |
| **File Explorer** | neo-tree (tree panel), oil.nvim (directory as buffer) |
| **Fuzzy Finding** | telescope + fzf-native |
| **LSP** | nvim-lspconfig, schemastore, flutter-tools |
| **Completion** | nvim-cmp + luasnip |
| **Treesitter** | All grammars, highlight + indent |
| **Debugging** | nvim-dap + dap-ui + dap-virtual-text |
| **Testing** | neotest + neotest-dart |
| **Task Runner** | overseer.nvim |
| **Formatting** | conform.nvim (format on save) |
| **Terminal** | toggleterm (Claude Code float, lazygit float) |
| **UI** | lualine, bufferline, noice, nvim-notify, indent-blankline, rainbow-delimiters, nvim-cursorline |
| **Editing** | which-key, nvim-autopairs, comment.nvim, todo-comments, trouble.nvim |
| **Screenshots** | silicon.nvim |

### Formatters

Configured via conform.nvim, runs on save:

| Language | Formatter |
|---|---|
| Nix | nixfmt |
| JS / TS / JSON / YAML / HTML / CSS / Markdown | prettier |
| Lua | stylua |

---

## Keymaps

`<leader>` is **Space**.

### Git

| Key | Action |
|---|---|
| `<leader>gs` | Open Neogit |
| `<leader>gd` | Open Diffview |
| `<leader>gD` | Close Diffview |

### Navigation

| Key | Action |
|---|---|
| `<leader>e` | Toggle Neo-tree file tree |
| `<leader>-` | Open Oil (current dir as buffer) |
| `<C-w>w` | Cycle window focus |
| `<C-w>h/l` | Move focus left / right |

### Telescope

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Open buffers |
| `<leader>fr` | Recent files |
| `<leader>fd` | Diagnostics |
| `<leader>fh` | Help tags |

### LSP

| Key | Action |
|---|---|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gy` | Go to type definition |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format buffer |
| `<leader>d` | Open diagnostic float |
| `[d` / `]d` | Previous / next diagnostic |

### Buffers

| Key | Action |
|---|---|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>bd` | Delete buffer |

### Debugging (DAP)

| Key | Action |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>du` | Toggle DAP UI |
| `<leader>dt` | Terminate session |

### Testing (Neotest)

| Key | Action |
|---|---|
| `<leader>nt` | Run nearest test |
| `<leader>nT` | Run all tests in file |
| `<leader>ns` | Toggle test summary |
| `<leader>no` | Open test output |

### Tasks (Overseer)

| Key | Action |
|---|---|
| `<leader>or` | Run task |
| `<leader>ot` | Toggle task list |
| `<leader>ol` | Load bundle |

### Terminal

| Key | Action |
|---|---|
| `<leader>tt` | Toggle Claude Code float terminal |
| `<leader>tg` | Toggle lazygit float terminal |
| `<Esc>` (in terminal) | Return to normal mode |

### Trouble

| Key | Action |
|---|---|
| `<leader>xx` | Toggle Trouble |
| `<leader>xw` | Workspace diagnostics |
| `<leader>xd` | Document diagnostics |
| `<leader>td` | Todo list (via Trouble) |

### Formatting

| Key | Action |
|---|---|
| `<leader>mp` | Format buffer (manual) |

### Screenshots

| Command | Action |
|---|---|
| `:Silicon` | Capture code screenshot → PNG |

---

## Structure

```
flake.nix                   # inputs: nixpkgs, core-flake, nixvim
neovim/
  default.nix               # root module: leader, opts, imports
  plugins/
    git.nix
    explorer.nix
    lsp.nix
    treesitter.nix
    completion.nix
    dap.nix
    testing.nix
    tasks.nix
    ui.nix
    editing.nix
    screenshot.nix
    telescope.nix
    terminal.nix
    formatting.nix
```

## Dev Shell

The flake exposes a dev shell with `gh` and `git` for repository management:

```bash
direnv allow   # loads the shell automatically via .envrc
```
