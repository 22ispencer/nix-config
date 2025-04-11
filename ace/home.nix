{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];

  mods = {
    emacs = {
      enable = true;
      withNativeComp = false;
    };
    langs = {
      svelte.enable = true;
    };
  };
}
