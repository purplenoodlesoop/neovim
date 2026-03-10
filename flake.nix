{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    core-flake = {
      url = "github:purplenoodlesoop/core-flake";
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
        };

    in
    perSystem // topLevel;
}
