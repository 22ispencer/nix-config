{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];
  mods = {
    jetbrains.enable = true;
    langs.svelte.enable = true;
    emacs.enable = true;
    lorri.enable = true;
  };
}
