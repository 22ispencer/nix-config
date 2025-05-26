{
  pkgs,
  lib,
  config,
  options,
}:
let
  mod = config.mods.firefox;
in
{
  options.mods.firefox.enable = {
    enable = lib.mkEnableOption "firefox";
  };
  config = lib.mkIf mod.enable {
    programs.firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
        }
      };
    };
  };
}
