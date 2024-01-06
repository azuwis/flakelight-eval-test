{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/cfc3698c31b1fb9cdcf10f36c9643460264d0ca8";

  outputs = { nixpkgs, ... }:
    let
      eachSystem = nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
    in
    {
      packages = eachSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.stdenv.mkDerivation {
            pname = "pkg1";
            version = "0.0.1";
            src = ./.;
            installPhase = "make DESTDIR=$out install";
          };
        }
      );
    };
}
