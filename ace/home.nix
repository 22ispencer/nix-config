{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];

  mods = {
    direnv.enable = true;
    emacs = {
      enable = true;
      withNativeComp = false;
    };
    langs = {
      svelte.enable = true;
    };
  };
}
