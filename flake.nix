{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-parts = {
      url = github:hercules-ci/flake-parts;
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    haskell-flake.url = github:srid/haskell-flake;
  };

  outputs = { flake-parts, haskell-flake, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        haskell-flake.flakeModule
      ];

      perSystem = { pkgs, ... }: {
        haskellProjects.default = {
          basePackages = pkgs.haskell.packages.ghc96;
          autoWire = [ "devShells" ];
        };
      };
    };
}
