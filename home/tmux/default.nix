{
  pkgs,
  config,
  lib,
  ...
}:
let
  mod = config.mods.tmux;
in
{
  options.mods.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf mod.enable {
    programs.tmux = {
      enabled = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        catppuccin
      ];
      extraConfig = ''
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix
      '';
    };
  };
}
