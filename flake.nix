{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) 
            scheme-small
            latexmk
            amsmath
            todonotes
            breakurl
            filecontents;
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = [ tex ];
        };
      });
}

