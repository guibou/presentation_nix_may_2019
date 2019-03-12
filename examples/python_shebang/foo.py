#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p python3 python3Packages.numpy

import numpy

print(numpy.zeros((10, 10)))
