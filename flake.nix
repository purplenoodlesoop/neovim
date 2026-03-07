{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    core-flake = {
      url = "github:purplenoodlesoop/core-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { core-flake, nixvim, ... }:
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
          flake.packages.default = nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
            module = ./neovim;
          };
        };
    };
}
