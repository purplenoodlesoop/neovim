# neovim

A [LazyVim](https://www.lazyvim.org/) configuration managed declaratively via [lazyvim-nix](https://github.com/pfassina/lazyvim-nix), exposed as a home-manager module.

## Usage

Add this flake as an input and import the home-manager module:

```nix
# flake.nix inputs
neovim.url = "github:purplenoodlesoop/neovim";

# home-manager configuration
imports = [ inputs.neovim.homeManagerModules.default ];
```

## Theme

[Cyberdream](https://github.com/scottmckendry/cyberdream.nvim) — dark, high-contrast, neon-accented theme with vivid purple/teal tones designed for extended coding sessions.

## Language Support

| Language | LSP | Notes |
|---|---|---|
| Nix | nixd | Expression-aware completion |
| Dart | dartls + dart_format | Requires Flutter SDK in PATH |
| Flutter | flutter-tools | Widget guides, closing tags, hot reload on save, DAP |
| Haskell | HLS | Requires HLS in PATH (ghcup) |
| TypeScript / JavaScript | ts_ls | |
| HTML | Treesitter only | |
| Markdown | marksman | |
| YAML | yamlls + SchemaStore | Auto schema detection |
| JSON | jsonls + SchemaStore | Auto schema detection |
| XML | Treesitter only | |
| SQL | sqls | |

Spellchecking (English) is enabled globally via `vim.opt.spell`.

## Features

| Category | Implementation |
|---|---|
| **Git** | gitsigns, diffview, merge editor, lazygit float (`lang.git` + snacks.nvim) |
| **File Explorer** | neo-tree |
| **Search / Picker** | snacks.nvim picker (built-in LazyVim default) |
| **Completion** | blink.cmp (LazyVim default) |
| **Diagnostics / Errors** | trouble.nvim |
| **Debugging** | nvim-dap + dap-ui (`dap.core`) |
| **Testing** | neotest + neotest-dart (`test.core`) |
| **Task Runner** | overseer.nvim |
| **Formatting** | conform.nvim — format on save for all supported languages |
| **Treesitter** | All LazyVim grammars + XML |
| **Indent Guides** | indent-blankline |
| **Rainbow Parens/Indents** | rainbow-delimiters.nvim |
| **Todo Comments** | todo-comments.nvim |
| **Screenshots** | nvim-silicon → `~/silicon-<timestamp>.png` (`:Silicon`) |
| **Cursor Line** | Built-in LazyVim (`cursorline = true`) |

## Formatters

All via conform.nvim, run on save:

| Language | Formatter |
|---|---|
| Dart | dart_format |
| Nix | nixfmt |
| JS / TS / JSON / YAML / CSS / Markdown | prettier |
| Haskell | ormolu (via HLS) |

---

## Structure

```
flake.nix               # inputs: nixpkgs, core-flake, lazyvim-nix
                        # outputs: homeManagerModules.default + devShell
lazyvim/
  default.nix           # programs.lazyvim: enable, extras, extraPackages
  plugins.nix           # custom plugins: theme, flutter-tools, rainbow, screenshot
  config.nix            # options, keymaps, autocmds
```

## Dev Shell

```bash
direnv allow            # loads gh + git via flake devShell
direnv exec . gh <args> # run devShell tools without entering the shell
```
