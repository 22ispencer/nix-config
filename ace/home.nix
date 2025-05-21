{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];

  home.packages = [
    pkgs.youtube-music
  ];

  mods = {
    direnv.enable = true;
    emacs = {
      enable = true;
      withNativeComp = false;
    };
    neovim.enable = true;
    langs = {
      svelte.enable = true;
    };
    tex.enable = true;
  };
}
