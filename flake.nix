{
  description = "Jason Sun's resume — LyX/LaTeX build";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        texenv = pkgs.texliveSmall.withPackages (ps: with ps; [
          datetime2
          tracklang
          booktabs
          hyperref
          geometry
          enumitem
          fancyhdr
          lastpage
          collection-fontsrecommended
        ]);
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.lyx
            texenv
          ];
        };

        packages.default = pkgs.stdenv.mkDerivation {
          pname = "jason-sun-resume";
          version = "2026-05-13";
          src = ./.;
          nativeBuildInputs = [ pkgs.lyx texenv ];
          buildPhase = ''
            export HOME=$(mktemp -d)
            lyx --export pdf2 resume.lyx
          '';
          installPhase = ''
            mkdir -p $out
            cp resume.pdf $out/jason-sun-resume.pdf
          '';
        };
      }
    );
}
