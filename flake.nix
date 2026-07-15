{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    core-flake = {
      # Branch adds the `systems` arg to evalFlake; point back at master once
      # https://github.com/purplenoodlesoop/core-flake/tree/evalflake-systems merges.
      url = "github:purplenoodlesoop/core-flake/evalflake-systems";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lazyvim-nix = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { core-flake, lazyvim-nix, ... }:
    let
      perSystem =
        with core-flake;
        lib.evalFlake {
          # nixpkgs unstable dropped x86_64-darwin; evaluating it throws.
          systems = [
            "aarch64-darwin"
            "aarch64-linux"
            "x86_64-linux"
          ];
          perSystem =
            { pkgs, ... }:
            {
              imports = with nixosModules; [
                tasks
              ];
              flake.shell = with pkgs; [
                gh
                git
              ];
              flake.packages.module-eval =
                let
                  lazyvimMod = import ./lazyvim { inherit pkgs; };
                in
                pkgs.buildEnv {
                  name = "neovim-config-check";
                  paths =
                    lazyvimMod.programs.lazyvim.extraPackages
                    ++ lazyvimMod.programs.lazyvim.treesitterParsers;
                };
            };
        };
      topLevel.homeManagerModules.default =
        { ... }:
        {
          imports = [
            lazyvim-nix.homeManagerModules.default
            ./lazyvim
          ];
          # Nix-attrset -> lazy.nvim spec generators (lazyConfig/lazyPlugin),
          # so plugin specs are checked at eval time instead of raw Lua strings.
          _module.args.lazyvimLib = lazyvim-nix.lib;
        };

    in
    perSystem // topLevel;
}
