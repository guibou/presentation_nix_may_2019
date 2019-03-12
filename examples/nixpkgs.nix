let
  rev = "6e5caa3f8ac";
in
import (fetchTarball {
  sha256 = "1l2dml622k0qi1ww2v4nyb97mqa4b69wnxfs4jralgsipsl1bcf3";
  url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
})
