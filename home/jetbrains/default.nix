{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.mods.jetbrains = {
    enable = lib.mkEnableOption "jetbrains IDEs";
  };
  config = lib.mkIf config.mods.jetbrains.enable {
    home.packages = [
      pkgs.jetbrains.datagrip
      pkgs.jetbrains.rider
    ];
  };
}
