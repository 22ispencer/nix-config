{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];

  editor.emacs.withNativeComp = false;
}
