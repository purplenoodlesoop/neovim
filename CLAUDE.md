# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

This flake produces a **home-manager module** — there is no standalone `nvim` binary. Activate by including the module in an existing home-manager configuration:

```nix
imports = [ inputs.neovim.homeManagerModules.default ];
```

Then switch:

```bash
home-manager switch   # in the consuming home-manager setup
```

Dev shell tools (gh, git) via direnv:

```bash
direnv allow               # one-time setup
direnv exec . gh <args>    # run any devShell tool without entering the shell
```

## Architecture

[lazyvim-nix](https://github.com/pfassina/lazyvim-nix) wraps [LazyVim](https://www.lazyvim.org/) as a home-manager module. LazyVim's core and extra plugins are pinned and symlinked from the Nix store ("dev mode"). Additional custom plugins (theme, flutter-tools, etc.) are managed by lazy.nvim at runtime.

**No init.lua to write** — all configuration is expressed in Nix via `programs.lazyvim` options.

### core-flake API

`lib.evalFlake` accepts:
- `perSystem = { pkgs, ... }: { ... }` — per-system config
- `flake.shell` — devShell tool list
- `tasks.<name>.body` — shell scripts exposed as `nix run .#<task>` (supports `${pkgs.foo}/bin/foo` interpolation)
- `nixosModules.tasks` must be imported for tasks to work

### lazyvim-nix API (`programs.lazyvim`)

| Option | Type | Description |
|---|---|---|
| `enable` | bool | Enable the module |
| `installCoreDependencies` | bool | Install git, ripgrep, fd, lazygit, fzf, curl |
| `extraPackages` | list | System packages added to nvim's PATH |
| `treesitterParsers` | list | Additional treesitter grammar packages from nixpkgs |
| `extras.<cat>.<name>.enable` | bool | Enable a LazyVim extra |
| `extras.<cat>.<name>.installDependencies` | bool | Install LSP/tools for this extra via Nix |
| `extras.<cat>.<name>.config` | str | Lua to override the extra's plugin spec (full spec with `return`) |
| `plugins.<name>` | str | Lua plugin spec → `lua/plugins/<name>.lua` (lazy.nvim fetches at runtime) |
| `config.options` | str | Lua → `lua/config/options.lua` |
| `config.keymaps` | str | Lua → `lua/config/keymaps.lua` |
| `config.autocmds` | str | Lua → `lua/config/autocmds.lua` |
| `configFiles` | path | Directory of Lua files to copy (alternative to inline strings) |

### Module structure

```
flake.nix               # inputs: nixpkgs, core-flake, lazyvim-nix
                        # outputs: homeManagerModules.default (merges core-flake devShell)
lazyvim/
  default.nix           # enable, extras, extraPackages, treesitterParsers
  plugins.nix           # programs.lazyvim.plugins — custom lazy.nvim plugin specs
  config.nix            # programs.lazyvim.config — options, keymaps, autocmds
```

### Custom plugin pattern

```nix
programs.lazyvim.plugins.my-plugin = ''
  return {
    "author/plugin-name",
    event = "BufReadPost",
    opts = { ... },
  }
'';
```

Plugins are written to `~/.config/nvim/lua/plugins/<name>.lua` and loaded by lazy.nvim. Packages the plugin needs (LSP binaries, CLI tools) go in `extraPackages`.

### Extras categories

Available: `ai`, `coding`, `dap`, `editor`, `formatting`, `lang`, `linting`, `lsp`, `test`, `ui`, `util`

Lang extras used here: `nix`, `dart`, `haskell`, `typescript`, `markdown`, `yaml`, `json`, `sql`, `git`

**Naming**: extras attribute names use underscores, not hyphens (e.g., `neo_tree`, `indent_blankline`).

### Splitting config across files

Since `programs.lazyvim` is a NixOS module, its sub-options (`plugins`, `extras`, etc.) merge across imported files. A file that only sets `programs.lazyvim.plugins.*` is a valid partial module.

## Nix Formatting Style

Use [nixfmt](https://github.com/NixOS/nixfmt) conventions:
- Each attrset entry on its own line; opening `{` on the same line as the key
- Closing `}` at the same indentation as the key
- `//` operator on its own line
- Function args `{ ... }:` on same line as brace, body indented 2 spaces

The flake merges system-agnostic outputs via:
```nix
let
  perSystem = with core-flake; lib.evalFlake { ... };
  topLevel.homeManagerModules.default = { ... }: { imports = [ ... ]; };
in
perSystem // topLevel;
```

## Dev Workflow

- Build: there is no `nix build` — changes take effect after `home-manager switch` in the consuming flake
- direnv loads flake devShell automatically when `.envrc` has `use flake .`
