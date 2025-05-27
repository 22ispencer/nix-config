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
    neovim.enable = true;
    tmux.enable = true;
    direnv.enable = true;
  };
}
