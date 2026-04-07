let
  pkgs = import <nixpkgs> {};
in pkgs.mkShell {
  packages = [
    pkgs.texlive.pkgs.latexmk
    pkgs.texlivePackages.todonotes
    pkgs.texliveTeTeX
  ];
}
