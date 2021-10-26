#!/bin/bash
# Script to build every package (excepted non public packages) of this repository
# to populate a public binary cache (especially the one used by travis)

export LANG=C

n_cores=10

build () {
  for p in $1
  do
	nix-build --cores $n_cores --arg pkgs 'import <nixpkgs> {}' -A $p
	if [ $? -ne 0 ]
	then
		echo -e "\nERROR: Build of $p into $c failed!" >&2
		exit 1
	fi
  done
}

# Build packages (with sandboxing on)
perl -pi -e "s/sandbox = false/sandbox = true/" ~/.config/nix/nix.conf

###### PACKAGES FOR LATEST CHANNEL #######
c="nixos-21.05"

export NIX_PATH="nixpkgs=channel:$c"
build "hello gerris obitools3 openmpi openmpi1 openmpi2 openmpi2-opa openmpi2-ib openmpi3 openmpi4 petscComplex petscReal arpackNG gmt szip mpi-ping hoppet applgrid fate migrate gdl zonation-core scotch-mumps hpl"

###### PACKAGES FOR OLD CHANNEL #######
c="nixos-20.03"
export NIX_PATH="nixpkgs=channel:$c"
build "hello gerris openmpi openmpi1 openmpi2 openmpi2-opa openmpi2-ib openmpi3 openmpi4 petscComplex petscReal arpackNG gmt szip mpi-ping hoppet applgrid fate migrate gdl zonation-core scotch-mumps hpl"


# Build packages that need sandboxing disabled
c="nixos-21.05"
perl -pi -e "s/sandbox = true/sandbox = false/" ~/.config/nix/nix.conf
export NIX_PATH="nixpkgs=$c"
#build "singularity"
perl -pi -e "s/sandbox = false/sandbox = true/" ~/.config/nix/nix.conf
