{
  pkgs,
  config,
  lib,
  nixConfigDir,
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
    programs.fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };
    programs.sesh = {
      enable = true;
      settings = {
        default_session = {
          startup_command = "nvim -c ':Neogit' -c ':Pick files'";
          preview_command = "eza --all --git --icons --color=always {}";
        };
        session = [
          {
            name = "nix config";
            path = nixConfigDir;
            startup_command = "nvim -c ':Neogit' -c ':Pick files'";
          }
        ];
      };
    };
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        vim-tmux-navigator
        pain-control
      ];
      shell = "$SHELL";
      shortcut = "Space";
      tmuxinator.enable = true;
      extraConfig = ''
        set -g default-command $SHELL

        ## enable mouse scrolling
        set -g mouse on

        ## reload tmux config
        bind C-r source-file ~/.config/tmux/tmux.conf

        ## rebuild nix config
        bind M-r popup -E -E ${./rebuild-switch.sh}

        ## catppuccin theme
        # fix color
        set -ag terminal-overrides ",$TERM:RGB"
        set -g @catppuccin_status_left_separator "█"
        set -g @catppuccin_status_middle_separator ""
        set -g @catppuccin_status_right_separator "█"
        set -g @catppuccin_window_current_text " #W"
        set -g @catppuccin_window_text " #W"
        # load plugin
        run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
        # Make the status line pretty and add some modules
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -agF status-right "#{E:@catppuccin_status_cpu}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
        # load deps
        run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
      '';
    };
  };
}
