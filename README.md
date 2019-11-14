# nur-packages

**GRICAD [NUR](https://github.com/nix-community/NUR) repository**

* Local build of a package:

```
nix-build --arg pkgs 'import <nixpkgs> {}' -A hello
```

* Optional pushing into the cache (need gricad cachix key)

```
nix-build --arg pkgs 'import <nixpkgs> {}' -A hello | cachix push gricad
```



[![Build Status](https://travis-ci.com/Gricad/nur-packages.svg?branch=master)](https://travis-ci.com/Gricad/nur-packages)
[![Cachix Cache](https://img.shields.io/badge/cachix-gricad-blue.svg)](https://gricad.cachix.org)


