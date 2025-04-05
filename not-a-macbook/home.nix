{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];

  mods.emacs.withNativeComp = false;
}
