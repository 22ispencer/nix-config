{
  pkgs,
  config,
  lib,
  ...
}:
let
  mod = config.mods.gaming.minecraft;
in
{
  options.mods.gaming.minecraft = {
    enable = lib.mkEnableOption "minecraft clients";
  };
  config = lib.mkIf mod.enable {
    home.packages = [
      (pkgs.prismlauncher.override {
        # Add binary required by some mod
        additionalPrograms = [ ];

        # Change Java runtimes available to Prism Launcher
        jdks = [
          pkgs.graalvm-ce
          pkgs.zulu8
          pkgs.zulu17
          pkgs.zulu
        ];
      })
      pkgs.lunar-client
    ];
  };
}
