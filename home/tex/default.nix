{ pkgs, config, lib, ... }:
let
  mod = config.mods.tex;
in
{
  options.mods.tex = {
    enable = lib.mkEnableOption "tex compilation tools";
  };
  config = lib.mkIf mod.enable {
    programs.texlive = {
      enable = true;
      package = pkgs.texliveFull;
    };
  };
}
