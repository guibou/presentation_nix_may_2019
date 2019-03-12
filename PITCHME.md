# Nix ou comment j'ai appris à ne plus m'en faire et à aimer les builds reproductibles

guillaum.bouchard@gmail.com

2019 Mai 12

---

## `whoami`

- PhD en 2014
- Industrie du cinéma : logiciels complexes

  - Plusieurs langages (C++ / Python / Haskell / OpenCL / Lua / ...)
  - Plusieurs interpreteurs à distribuer
  - Plusieurs systèmes d'exploitation (Linux / Mac OSX / Windows)
  - Plusieurs versions à maintenir en simultanée
  
- Depuis juin 2018 : tweag.io / kittyhawk

  - Industrie de l'aéronautique
  - Contrainte de qualité (certification)
  - Build cross plateforme / architecture 
  

- Posez vos questions, sinon on finira vite et je serais forcé de vous
  parler de mes 2 enfants et de parachutisme.

---
## Build logiciel

- Des entrées
- Des sorties
- Un environment

- Logiciels
- Experiences
- Publications (Latex)
- Site web
- Configuration d'ordinateur
- ...

---
## Reproducibilité

- Toujours obtenir la même chose
- Facilement

- Pourquoi ?

  - Qualité
  - Sécurité
  - Facilité

---
## Le Saint Graal


```
$ cat README.md

To build this project, please run `nix build`

```


---
## Nix

---
## Nix : détails

- Outil d'orchestration de build

  - Fournie les dépendances
  - Sandboxé
  - Sous-traite à vos outils (make, cmake, bazel, shake, scons, ...)

- Environnements

  - Indépendants
  - Autant que necessaires (plusieurs par projets)

---
## Nix : Philosophie

- *Sharable* : mon environnement est dans mon dépot de source
- *Forkable* : tu peux éditer mon environnement pour tes besoins
- *Reproductible* : toi et moi avons exactement le même environment


---
## Nix : langage
 
```
stdenv.mkDerivation rec {
   name = "foo-${version}";
   version = "3.14";
   
   src = fetchurl {
     url = http://hurray.for.skolems/foo.tar.gz;
	 sha256 = "abcd...";
   };
   
   buildInputs = [ ncurses ];
   
   # buildPhase / installPhase uses make by default
}
```

---
## Nix : call and override

```
foo = callPackage ./foo.nix {};
```

```
foo2 = foo.overrideAttrs (oldAttrs : {
   src = ...;
   configureFlags = old.configureFlags ++ ["-fsuper-bar"];
});
```


---
## Nixpkgs

- Grande base de donnée de package
- Helper pour differents environment (make / autotools / cmake / python / haskell / rust / ...)
- Language nix: surchargeable !


---
## Nix : cache

- Tout est caché
- Selon les hash des input.
- Cache binaire proposé par la communauté
- Cache local
- Cache binaire as a service (cachix)

  
---
## Nix : `nix-shell`

```
$ gcc
gcc: command not found
```

```
$ nix-shell -p gcc7
(nix-shell) $ gcc -v
gcc 7
```

```
$ nix-shell -p gcc6
(nix-shell) $ gcc -v
gcc 6
```

---
## Nix : `nix-shell`

```
$ python
python: command not found
```

```
$ nix-shell -p python27
(nix-shell) $ python
Python 2.7.15 ....
>>> import numpy
... ImportError: No module named numpy
```

```
$ nix-shell -p python36 -p python36Packages.numpy
(nix-shell) $ python
Python 3.6.11 ....
>>> import numpy
>>> # OK !
```

---
## Pinning

```
import (fetchTarball {
  sha256 = "1l2dml622k0qi1ww2v4nyb97mqa4b69wnxfs4jralgsipsl1bcf3";
  url = "https://github.com/NixOS/nixpkgs/archive/6e5caa3f8ac.tar.gz";
})
```

---
## Shebang

```
#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p python3 python3Packages.numpy

import numpy

print(numpy.zeros((10, 10)))
```

---
## Shell fixe

```
with import ../nixpkgs.nix {};
mkShell {
  buildInputs = [
    (python3.withPackages(p : [p.numpy p.pytorch]))
    blender
    ];
}
```

---
## Full (Latex) Project build

```
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
```

---
## Docker

```
with import ../nixpkgs.nix {};
dockerTools.buildImage {
  name = "poulet";

  contents = [ git ];
}
```

---
## CROSS build

- Cross compilation facile
- Windows / ARM / ...
- Examples :

  - KH
  - Guerilla

---
## NIXOS

- OS avec Nix en package manager
- Configuration dans un fichier
- Montrer mon fichier de config

---
## Home Manager

- Configuration de l'utilisateur dans un fichier
- Montrer un peu ma config
