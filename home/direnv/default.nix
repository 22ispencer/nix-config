{
  pkgs,
  lib,
  config,
  ...
}:
let
  mod = config.mods.direnv;
in
{
  options.mods.direnv = {
    enable = lib.mkEnableOption "direnv";
  };
  config = lib.mkIf mod.enable {
    home.packages = [
      pkgs.devenv
    ];
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
