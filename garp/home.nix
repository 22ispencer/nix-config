{ pkgs, ... }:
{
  imports = [
    ../home/default.nix
  ];
  home = {
    packages = [
      pkgs.qalculate-gtk
      pkgs.texliveFull
    ];
    sessionVariables = {
      GDK_SCALE = 2;
    };
  };
  mods = {
    jetbrains.enable = true;
    langs.svelte.enable = true;
    emacs.enable = true;
    direnv.enable = true;
  };
}
