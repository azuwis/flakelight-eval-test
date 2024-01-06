{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/cfc3698c31b1fb9cdcf10f36c9643460264d0ca8";
  inputs.flakelight.url = "github:nix-community/flakelight";
  inputs.flakelight.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { flakelight, ... }:
    flakelight ./. {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      package = { stdenv }:
        stdenv.mkDerivation {
          pname = "pkg1";
          version = "0.0.1";
          src = ./.;
          installPhase = "make DESTDIR=$out install";
        };
    };
}
