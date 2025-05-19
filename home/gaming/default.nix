{
  pkgs,
  config,
  lib,
  ...
}:
let
  mod = config.mods.gaming;
in
{
  imports = [
    ./minecraft
  ];
  options.mods.gaming = {
    discord.enable = lib.mkEnableOption "discord";
  };
  config = {

    home.packages = [
      (lib.mkIf mod.discord.enable pkgs.legcord)
    ];
  };
}
