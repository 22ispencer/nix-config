{
  pkgs,
  lib,
  config,
  ...
}:
let
  mod = config.mods.lorri;
in
{
  options.mods.lorri = {
    enable = lib.mkEnableOption "lorri";
  };

  config = lib.mkIf mod.enable {
    services.lorri.enable = true;
    programs.direnv.enable = true;
  };
}
