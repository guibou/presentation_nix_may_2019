with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "superPaper";

  src = ./.;

  buildInputs = [
    (texlive.combine { inherit (texlive) scheme-basic; })
    graphviz
  ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    cp doc.pdf $out
  '';
}
