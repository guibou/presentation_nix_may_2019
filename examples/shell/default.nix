with import ../nixpkgs.nix {};
mkShell {
  buildInputs = [
    (python3.withPackages(p : [p.numpy p.pytorch]))
    blender
    ];
}
