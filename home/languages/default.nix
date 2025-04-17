{
  pkgs,
  lib,
  options,
  config,
  ...
}:
{
  imports = [
    ./nix.nix
    ./svelte.nix
    ./typescript.nix
  ];
}
