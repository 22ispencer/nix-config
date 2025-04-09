{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];
  mods.jetbrains.enable = true;
}
