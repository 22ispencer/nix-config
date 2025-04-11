{ pkgs, lib, config, ... }:
let
  mod = config.mods.langs.typescript;
in {
  options.mods.langs.typescript = {
    enable = lib.mkEnableOption "typscript tooling";
    formatter = lib.mkOption {
      default = true;
      description = "Install formatter";
      type = lib.types.bool;
    };
  };
  config = lib.mkIf mod.enable {
    home.packages = [
      pkgs.typescript-language-server
      (lib.mkIf mod.formatter pkgs.nodePackages.prettier)
    ];
  };
}
