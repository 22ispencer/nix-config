{ pkgs, lib, config, options, ... }:
{
  options.mods.cli = {
    enable = lib.mkEnableOption "cli options";
  };
  config = lib.mkIf config.mods.cli.enable {
    programs.zsh = {
      enable = true;
      initExtraBeforeCompInit = ''
        zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
      '';
      initExtra = ''
        WORDCHARS='_-.[]()'
      '';
      autosuggestion.enable = true; 
      syntaxHighlighting.enable = true;
    };
    home.packages = [
      pkgs.bat
      pkgs.fd
      pkgs.ripgrep
    ];
    programs.eza = {
      enable = true;
      icons = "auto";
    };
  };
}
