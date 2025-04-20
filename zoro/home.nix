{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];
  mods = {
    emacs.enable = true;
    direnv.enable = true;
    ghostty.enable = true;
    tex.enable = true;
  };
}
