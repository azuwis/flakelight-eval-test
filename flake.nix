{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/cfc3698c31b1fb9cdcf10f36c9643460264d0ca8";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  inputs.flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem = { pkgs, ... }: {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "pkg1";
          version = "0.0.1";
          src = ./.;
          installPhase = "make DESTDIR=$out install";
        };
      };
    };
}
