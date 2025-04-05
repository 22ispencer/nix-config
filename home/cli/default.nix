{ pkgs, lib, config, options, ... }:
{
  options.mods.cli = {
    enable = lib.mkEnableOption "cli options";
  };
  config = lib.mkIf config.mods.cli.enable {
    programs.zsh = {
      enable = true;
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
