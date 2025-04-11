{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];
  mods.jetbrains.enable = true;
  mods.langs.svelte.enable = true;
  mods.emacs.enable = true;
}
