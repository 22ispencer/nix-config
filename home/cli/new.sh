#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "a single project name is required"
  exit 1
fi

nix flake new -t github:22ispencer/nix-templates#utils $1
cd "./$1"
direnv allow .
nvim flake.nix
