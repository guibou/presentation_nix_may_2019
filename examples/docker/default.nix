with import ../nixpkgs.nix {};
dockerTools.buildImage {
  name = "poulet";

  contents = [ git ];
}
