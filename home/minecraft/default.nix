{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.mods.minecraft = {
    enable = lib.mkEnableOption "minecraft clients";
  };
  config = lib.mkIf config.mods.minecraft.enable {
    home.packages = [
      (prismlauncher.override {
        # Add binary required by some mod
        additionalPrograms = [ ];

        # Change Java runtimes available to Prism Launcher
        jdks = [
          graalvm-ce
          zulu8
          zulu17
          zulu
        ];
      })
    ];
  };
}
