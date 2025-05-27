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
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        catppuccin
      ];
      extraConfig = ''
        # setup leader
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix

        ## catppuccin theme
        # fix color
        set -ag terminal-overrides ",$TERM:RGB"
        # Make the status line pretty and add some modules
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
        set -agF status-right "#{E:@catppuccin_status_battery}"
      '';
    };
  };
}
