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
    jetbrains.enable = true;
    neovim.enable = true;
    langs = {
      svelte.enable = true;
    };
    tex.enable = true;
    tmux.enable = true;
  };
}
